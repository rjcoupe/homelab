resource "proxmox_vm_qemu" "k8s_workers" {
  depends_on = [
      null_resource.user_init,
      null_resource.network_init_dhcpv4
    ]

  count       = var.k8s_workers
  name        = "worker-${count.index + 1}"
  target_node = "pve"
  clone       = "ubuntu-impish-cloudinit"
  full_clone  = false

  memory = 4096
  balloon = 4096

  os_type  = "cloud-init"
  cicustom = "user=snippets:snippets/user.yaml,network=snippets:snippets/network_dhcpv4.yaml"
  
  agent = 1

  bootdisk = "scsi0"
  scsihw = "virtio-scsi-pci"

  tags = "kubernetes-worker"

  disk {
    type    = "virtio"
    storage = "local-lvm"
    size    = "32G"
  }

  lifecycle {
    ignore_changes = [
      network
    ]
  }
}

resource "proxmox_vm_qemu" "k8s_master" {
  depends_on = [
      null_resource.user_init,
      null_resource.network_init_dhcpv4
    ]

  name        = "master"
  target_node = "pve"
  clone       = "ubuntu-impish-cloudinit"
  full_clone  = false

  sockets = 1
  cores = 2

  memory = 4096
  balloon = 4096

  os_type  = "cloud-init"
  cicustom = "user=snippets:snippets/user.yaml,network=snippets:snippets/network_dhcpv4.yaml"
  
  agent = 1

  bootdisk = "scsi0"
  scsihw = "virtio-scsi-pci"

  tags = "kubernetes-master"

  disk {
    type    = "virtio"
    storage = "local-lvm"
    size    = "32G"
  }

  lifecycle {
    ignore_changes = [
      network
    ]
  }
}