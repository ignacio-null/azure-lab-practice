variable "location" {
  description = "Region de Azure"
  type        = string
}

variable "prefix" {
  description = "Prefijo del proyecto"
  type        = string
}

variable "environment" {
  description = "Nombre del ambiente (dev, prod, qa)"
  type        = string
}

variable "contact_email" {
  description = "Email para alertas de presupuesto"
  type        = string
}

variable "app_service_sku" {
  description = "SKU del plan de servicio (F1, B1, P1v2)"
  type        = string
  default     = "F1"
}

variable "enable_always_on" {
  description = "Habilitar Always On (False para Free Tier)"
  type        = bool
  default     = false
}

variable "create_database" {
  description = "Crear base de datos (False para ahorrar costos)"
  type        = bool
  default     = true
}

variable "enable_free_tier" {
  description = "Habilitar capa gratuita en CosmosDB (Solo 1 por cuenta)"
  type        = bool
  default     = false
}

variable "budget_amount" {
  description = "Limite de presupuesto mensual"
  type        = number
  default     = 20
}
