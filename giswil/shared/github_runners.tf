data "github_actions_registration_token" "github_runner" {
  for_each   = var.pipeline_runners
  repository = each.value.github_repo
}

resource "maas_instance" "runners" {
  for_each = var.pipeline_runners
  deploy_params {
    user_data = templatefile("${path.module}/cloud-init/github_runner/user_data.tftpl", {
      github_token   = data.github_actions_registration_token.github_runner[each.key].token
      github_repo    = each.value.github_repo
      owner          = "migueltinembart"
      runner_version = each.value.runner_version
    })
    distro_series = "focal"
  }
  
  allocate_params {
    hostname = "kvm-1"
    min_cpu_count = 1
    min_memory = 2048
  }
  timeouts {
    delete = "1m"
  }
  lifecycle {
    ignore_changes = [
      deploy_params["user_data"]
    ]
  }
}
