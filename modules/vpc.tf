resource "google_compute_network" "main" {
  name                    = var.project_id
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "main" {
  name    = var.project_id
  region  = var.location
  network = google_compute_network.main.self_link

  ip_cidr_range = "10.10.0.0/16"
  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_global_address" "private_ip_address" {
  name          = "private-ip-address"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  address       = "10.20.0.0"
  prefix_length = 16
  network       = google_compute_network.main.self_link
}

resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = google_compute_network.main.self_link
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [
    google_compute_global_address.private_ip_address.name
  ]
}

resource "google_vpc_access_connector" "main" {
  provider      = google-beta
  name          = var.project_id
  region        = var.location
  ip_cidr_range = "10.30.0.0/28"
  network       = google_compute_network.main.name
  machine_type  = "e2-micro"
  min_instances = 2
  max_instances = 3
}

