data "maas_machine" "kvm_hosts" {
  for_each = var.kvm_hosts
  hostname = each.value
}

## resource "maas_instance" "instances" {
##   for_each = var.pipeline_runners
##   deploy_params {
##     user_data     = file("${path.module}/infra_runner.yaml")
##     distro_series = "jammy"
##   }
##   allocate_params {
##     hostname      = "kvm-1"
##     min_cpu_count = each.value.cores
##     min_memory    = each.value.memory
##   }
## 
## }
