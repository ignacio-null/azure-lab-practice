terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "practice-lab-mgmt-rg"
    storage_account_name = "practicelabtfstate"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

# ---------------------------------------------------------
# 1. AMBIENTE DEV (Gratis Real)
# ---------------------------------------------------------
module "dev" {
  source = "./modules/standard_arch"

  environment      = "dev"
  location         = var.location
  prefix           = var.prefix
  contact_email    = var.contact_email
  
  # Config: Todo Gratis
  app_service_sku  = "F1"
  create_database  = true  # <--- Creamos la DB Gratis aquí
  enable_free_tier = false
  budget_amount    = 20
}

# ---------------------------------------------------------
# 2. AMBIENTE QA (Solo Web, Sin DB)
# ---------------------------------------------------------
module "qa" {
  source = "./modules/standard_arch"

  environment      = "qa"
  location         = var.location
  prefix           = var.prefix
  contact_email    = var.contact_email
  
  # Config: Ahorro Máximo
  app_service_sku  = "F1"
  create_database  = false # <--- NO creamos DB para no pagar
  budget_amount    = 10
}

# ---------------------------------------------------------
# 3. AMBIENTE PROD (Simulado, Sin DB)
# ---------------------------------------------------------
module "prod" {
  source = "./modules/standard_arch"

  environment      = "prod"
  location         = var.location
  prefix           = var.prefix
  contact_email    = var.contact_email
  
  # Config: Simulación Enterprise (Pero barata)
  app_service_sku  = "B1"  # Para probar un tier de pago (destruir luego)
  enable_always_on = true  # Probamos feature de pago
  create_database  = false # <--- NO creamos DB para no pagar $24
  budget_amount    = 50
}
