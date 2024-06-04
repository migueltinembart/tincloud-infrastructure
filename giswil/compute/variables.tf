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
    vlan_id     = number
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

variable "vlans" {
  type = list(object({
    vid  = number
    name = string
  }))
  description = "List of VLANs to be created"
}

variable "dns_records" {
  type = map(object({
    name = string
    type = string
    ttl  = number
    data = string
  }))
}
