data "template_file" "user_init" {
  template = file("${path.module}/cloud_configs/user.yaml")

  vars = {
      ssh_pub_key = file("${path.module}/ssh_pub_key")
  }
}

resource "local_file" "user_init" {
  content  = data.template_file.user_init.rendered
  filename = "${path.module}/files/user_init.yaml"
}

resource "null_resource" "user_init" {
  connection {
    type        = "ssh"
    user        = "root"
    private_key = file("~/.ssh/id_rsa")
    host        = var.pm_host
  }

  provisioner "file" {
    source      = local_file.user_init.filename
    destination = "/snippets/snippets/user.yaml"
  }
}

resource "null_resource" "network_init_dhcpv4" {
    connection {
        type        = "ssh"
        user        = "root"
        private_key = file("~/.ssh/id_rsa")
        host        = var.pm_host
    }

    provisioner "file" {
        source      = "${path.module}/cloud_configs/network_dhcpv4.yaml"
        destination = "/snippets/snippets/network_dhcpv4.yaml"
    } 
}