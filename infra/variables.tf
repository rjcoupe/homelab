variable "pm_host" {
  type        = string
  description = "Hostname of Proxmox host"
}

variable "pm_port" {
  type        = number
  description = "Port on which the Proxmox API listens"
  default     = 8006
}

variable "k8s_workers" {
  type    = number
  default = 0
}