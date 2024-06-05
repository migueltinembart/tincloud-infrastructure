variable "maas_api_url" {
  description = "URL for the MAAS provider"
  type        = string
}

variable "maas_api_key" {
  description = "API key for the MAAS provider"
  type        = string
  sensitive   = true
}

variable "fabric" {
  type = object({
    id   = optional(number)
    name = string
  })
}

variable "pool" {
  type = object({
    id   = optional(number)
    name = string
  })
}

variable "subnets" {
  type = map(object({
    vlan_id     = string
    cidr        = string
    gateway     = string
    dns_servers = list(string)
    dhcp_ranges = set(object({
      type     = string
      start_ip = string
      end_ip   = string
    }))
  }))
}

## variable "dns_records" {
##   type = map(object({
##     name = string
##     type = string
##     ttl  = number
##     data = string
##   }))
## }
