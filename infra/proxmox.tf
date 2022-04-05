terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "2.9.6"
    }
  }
}

provider "proxmox" {
  pm_api_url      = "https://${var.pm_host}:${var.pm_port}/api2/json"
  pm_tls_insecure = true
}