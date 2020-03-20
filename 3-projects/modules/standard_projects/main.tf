locals {
    parent_id = var.folder_id == "" ? "org/${var.org_id}" : "folders/${var.folder_id}"
}

module "nonprod_project" {
  source                      = "terraform-google-modules/project-factory/google"
  version                     = "~> 7.0"
  random_project_id           = "true"
  impersonate_service_account = var.impersonate_service_account
  default_service_account     = "depriviledge"
  activate_apis               = var.activate_apis
  name                        = "${var.project_prefix}-nonprod"
  org_id                      = var.org_id
  billing_account             = var.billing_account
  folder_id                   = google_folder.nonprod.id

#   shared_vpc         = local.nonprod_host_project_id
#   shared_vpc_subnets = data.google_compute_network.nonprod_shared_vpc.subnetworks_self_links

  labels = {
    environment      = "nonprod"
    cost_centre      = var.cost_centre
    application_name = var.application_name
  }
}