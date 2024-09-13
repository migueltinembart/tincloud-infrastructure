data "proxmox_virtual_environment_node" "nodes" {
  for_each  = var.proxmox_nodes
  node_name = each.value
}

data "proxmox_virtual_environment_datastores" "store" {
  for_each  = var.proxmox_nodes
  node_name = each.value
}

data "github_actions_registration_token" "runner_token" {
  for_each   = var.github_runners
  repository = each.value["repo"]
}

resource "proxmox_virtual_environment_vm" "github_runner" {
  for_each  = var.github_runners
  name      = each.key
  node_name = each.value["node_name"]
  tags      = ["terraform"]
  started   = true

  agent {
    enabled = true
  }


  disk {
    datastore_id = "local-lvm"
    file_id      = proxmox_virtual_environment_download_file.ubuntu_cloud_image.id
    interface    = "virtio0"
    iothread     = true
    discard      = "on"
    size         = 15
  }

  memory {
    floating = 1024
  }

  initialization {
    user_data_file_id = proxmox_virtual_environment_file.user_data[each.key].id
  }
}

resource "proxmox_virtual_environment_download_file" "ubuntu_cloud_image" {
  content_type = "iso"
  datastore_id = "local"
  node_name    = "hv01"
  url          = "https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img"
  file_name    = "ubuntu-jammy.img"
}


resource "proxmox_virtual_environment_file" "user_data" {
  for_each     = var.github_runners
  content_type = "snippets"
  datastore_id = "local"
  node_name    = "hv01"

  source_raw {
    data = templatefile("${path.module}/cloud-init/github_runner/user_data.tftpl", {
      runner_version = each.value["runner_version"]
      owner          = each.value["owner"]
      github_repo    = each.value["repo"]
      github_token   = data.github_actions_registration_token.runner_token[each.key].token
    })
    file_name = join("-", ["runner-1", "userdata"])
  }
}

