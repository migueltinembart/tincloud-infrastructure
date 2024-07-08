variable "cloudflare_api_token" {
  description = "value of the Cloudflare API token"
  type        = string
}

variable "account_id" {
  description = "value of the Cloudflare account ID"
  type        = string

}
variable "records" {
  type = map(object({
    name     = string
    value    = string
    type     = string
    priority = optional(number, 2048)
    ttl      = optional(number, 1)
  }))
}
