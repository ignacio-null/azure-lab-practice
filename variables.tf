variable "location" {
  description = "The Azure Region in which all resources in this example should be created."
  default     = "Central US"
}

variable "prefix" {
  description = "The prefix which should be used for all resources in this example"
  default     = "practice-lab"
}

variable "contact_email" {
  description = "Email address for budget alerts"
  default     = "ignacio.morales@live.com"
}
