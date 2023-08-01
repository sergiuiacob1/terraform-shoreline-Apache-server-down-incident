resource "shoreline_notebook" "apache_server_down_incident" {
  name       = "apache_server_down_incident"
  data       = file("${path.module}/data/apache_server_down_incident.json")
  depends_on = [shoreline_action.invoke_restart_apache_service,shoreline_action.invoke_apache_restart_status,shoreline_action.invoke_apache_conf_checker]
}

resource "shoreline_file" "restart_apache_service" {
  name             = "restart_apache_service"
  input_file       = "${path.module}/data/restart_apache_service.sh"
  md5              = filemd5("${path.module}/data/restart_apache_service.sh")
  description      = "Restart Apache service"
  destination_path = "/agent/scripts/restart_apache_service.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_file" "apache_restart_status" {
  name             = "apache_restart_status"
  input_file       = "${path.module}/data/apache_restart_status.sh"
  md5              = filemd5("${path.module}/data/apache_restart_status.sh")
  description      = "Check service status again"
  destination_path = "/agent/scripts/apache_restart_status.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_file" "apache_conf_checker" {
  name             = "apache_conf_checker"
  input_file       = "${path.module}/data/apache_conf_checker.sh"
  md5              = filemd5("${path.module}/data/apache_conf_checker.sh")
  description      = "Check for any configuration errors or updates that may have caused the issue and correct them as needed."
  destination_path = "/agent/scripts/apache_conf_checker.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_restart_apache_service" {
  name        = "invoke_restart_apache_service"
  description = "Restart Apache service"
  command     = "`/agent/scripts/restart_apache_service.sh`"
  params      = []
  file_deps   = ["restart_apache_service"]
  enabled     = true
  depends_on  = [shoreline_file.restart_apache_service]
}

resource "shoreline_action" "invoke_apache_restart_status" {
  name        = "invoke_apache_restart_status"
  description = "Check service status again"
  command     = "`/agent/scripts/apache_restart_status.sh`"
  params      = []
  file_deps   = ["apache_restart_status"]
  enabled     = true
  depends_on  = [shoreline_file.apache_restart_status]
}

resource "shoreline_action" "invoke_apache_conf_checker" {
  name        = "invoke_apache_conf_checker"
  description = "Check for any configuration errors or updates that may have caused the issue and correct them as needed."
  command     = "`/agent/scripts/apache_conf_checker.sh`"
  params      = ["PATH_TO_APACHE_CONF_FILE"]
  file_deps   = ["apache_conf_checker"]
  enabled     = true
  depends_on  = [shoreline_file.apache_conf_checker]
}

