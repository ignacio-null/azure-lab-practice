terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "${var.prefix}-${var.environment}-rg"
  location = var.location
}

# Storage Account
resource "azurerm_storage_account" "sa" {
  name                     = "${replace(var.prefix, "-", "")}${var.environment}store${random_string.suffix.result}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# App Service Plan
resource "azurerm_service_plan" "asp" {
  name                = "${var.prefix}-${var.environment}-asp"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  os_type             = "Linux"
  sku_name            = var.app_service_sku
}

# Web App
resource "azurerm_linux_web_app" "app" {
  name                = "${var.prefix}-${var.environment}-app"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  service_plan_id     = azurerm_service_plan.asp.id

  site_config {
    always_on = var.enable_always_on
  }
}

# Cosmos DB (CONDICIONAL - Solo si create_database es true)
resource "azurerm_cosmosdb_account" "db" {
  count               = var.create_database ? 1 : 0 # Truco para hacerlo opcional

  name                = "${var.prefix}-${var.environment}-cosmos"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"

  free_tier_enabled = var.enable_free_tier

  consistency_policy {
    consistency_level = "Session"
  }

  geo_location {
    location          = azurerm_resource_group.rg.location
    failover_priority = 0
  }
}

# Budget (Airbag)
resource "azurerm_consumption_budget_resource_group" "budget" {
  name              = "${var.prefix}-${var.environment}-budget"
  resource_group_id = azurerm_resource_group.rg.id

  amount     = var.budget_amount
  time_grain = "Monthly"

  time_period {
    start_date = formatdate("YYYY-MM-01'T'00:00:00Z", timestamp())
  }

  notification {
    enabled   = true
    threshold = 50.0
    operator  = "EqualTo"
    contact_emails = [var.contact_email]
  }

  notification {
    enabled   = true
    threshold = 75.0
    operator  = "EqualTo"
    contact_emails = [var.contact_email]
  }

  notification {
    enabled   = true
    threshold = 100.0
    operator  = "GreaterThanOrEqualTo"
    contact_emails = [var.contact_email]
  }
}

resource "random_string" "suffix" {
  length  = 4
  special = false
  upper   = false
}
