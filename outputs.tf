# --- DEV ---
output "dev_web_url" {
  value = module.dev.web_app_url
}
output "dev_rg" {
  value = module.dev.resource_group_name
}
output "dev_db_status" {
  value = module.dev.cosmos_db_endpoint
}

# --- QA ---
output "qa_web_url" {
  value = module.qa.web_app_url
}
output "qa_rg" {
  value = module.qa.resource_group_name
}
output "qa_db_status" {
  value = module.qa.cosmos_db_endpoint
}

# --- PROD ---
output "prod_web_url" {
  value = module.prod.web_app_url
}
output "prod_rg" {
  value = module.prod.resource_group_name
}
output "prod_db_status" {
  value = module.prod.cosmos_db_endpoint
}
