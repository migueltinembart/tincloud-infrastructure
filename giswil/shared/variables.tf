variable "proxmox_endpoint" {
  type        = string
  description = "The url of the proxmox hypervisor to connect to"
}

variable "proxmox_api_token" {
  type        = string
  sensitive   = true
  description = "the api token for the proxmox instance with which to authenticate to"
}

variable "proxmox_tls_insecure" {
  type        = bool
  description = "if the tls certificate is trusted or not. If true the tls certificate will not be checked"
}

variable "github_token" {
  type        = string
  sensitive   = true
  description = "the github authentication token used for the provider"
}

variable "proxmox_nodes" {
  type        = set(string)
  description = "a list of nodes with their names"
}

variable "ssh_private_key" {
  type      = string
  sensitive = true
}

variable "github_runners" {
  type = map(object({
    runner_version = string
    owner          = string
    repo           = string
    node_name      = string
  }))
}
