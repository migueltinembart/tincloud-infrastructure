variable "maas_api_url" {
  description = "URL for the MAAS provider"
  type        = string
}

variable "maas_api_key" {
  description = "API key for the MAAS provider"
  type        = string
  sensitive   = true
}

variable "github_token" {
  description = "Token for the GitHub provider"
  type        = string
  sensitive   = true
}

variable "domains" {
  type = set(string)

}

variable "kvm_hosts" {
  type = set(string)
}

variable "pipeline_runners" {
  type = map(object({
    kvm_host  = string
    cores     = number
    memory    = number
    storage   = number
    user_data = string
  }))
}

