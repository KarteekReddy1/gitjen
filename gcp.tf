provider "google" {
  region  = "us-central1"
  project = "machine-494406"
  impersonate_service_account = "terra-jen@machine-494406.iam.gserviceaccount.com"

}

resource "google_compute_instance" "gcp_instance" {
  name         = "gcp-instance"
  machine_type = "e2-micro"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }
  network_interface {
    network = "default"
    access_config {
    }
  }
}
#######################################

resource "google_compute_network" "custom_vpc" {
  name                    = "custom-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "custom_subnet" {
  name          = "custom-subnet"
  region        = "us-central1"
  network       = google_compute_network.custom_vpc.id
  ip_cidr_range = "10.0.0.0/24"
}



resource "google_compute_instance" "vm1" {
  name         = "vm1"
  machine_type = "e2-micro"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }
  network_interface {
    subnetwork = google_compute_subnetwork.custom_subnet.id
    access_config {
    }
  }
}
