variable "dns_servers" {
  type        = list(string)
  description = "List of DNS servers"
}

variable "dns_entries" {
  type = list(object({
    name = string
    ip   = string
  }))
  validation {
    # Check Format for ip regex
    condition     = alltrue([
      for entry in var.dns_entries : can(regex("^(?:[0-9]{1,3}\.){3}[0-9]{1,3}$", entry.ip))
    ])
    error_message = "Not in correct format. bust be an IP address"
  }
}

variable "gateway_ip" {
  type        = object({
    name = string
    ip   = string
  })
  description = "Gateway IP address"
}

variable "cidr_entries" {
  type        = object({
    name = string
    cidr = string
  })
  description = "CIDR for the subnet"
}

variable "fabric" {
  type = object({
    id   = string
    name = string
  })
}

variable "vlan" {
  type = object({
    vid  = number
    name = string
  })
  description = "VLAN ID"
}

variable "name" {
  type        = string
  description = "Name of the subnet"
}

