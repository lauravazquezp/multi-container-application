terraform {
  required_providers {
    multipass = {
      source  = "todoroff/multipass"
      version = "~> 1.5.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.0"
    }
  }
}

provider "multipass" {}

resource "multipass_instance" "todo_vm" {
  name   = "todo-api-server"
  cpus   = 1
  memory = "1G"   # Changed from 1GiB to 1G
  disk   = "5G"   # Changed from 5GiB to 5G
  image  = "22.04"
  
  cloud_init = <<-EOT
    #cloud-config
    users:
      - name: ubuntu
        sudo: ALL=(ALL) NOPASSWD:ALL
        shell: /bin/bash
        ssh_authorized_keys:
          - ${file("~/.ssh/id_rsa.pub")}
    EOT
}

resource "local_file" "ansible_inventory" {
  content  = multipass_instance.todo_vm.ipv4[0]
  filename = "${path.module}/../ansible/inventory.ini"
}

output "vm_ip" {
  value = multipass_instance.todo_vm.ipv4[0]
}
