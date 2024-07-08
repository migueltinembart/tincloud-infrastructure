resource "cloudflare_zone" "tincloud_tech" {
  account_id = var.account_id
  zone       = "tincloud.tech"
  plan       = "free"
}

resource "cloudflare_zone_dnssec" "tincloud_tech" {
  zone_id = cloudflare_zone.tincloud_tech.id
}

resource "cloudflare_record" "entra_records" {
  for_each = var.records
  zone_id  = cloudflare_zone.tincloud_tech.id
  name     = each.value.name
  value    = each.value.value
  type     = each.value.type
  priority = each.value.priority
  ttl      = each.value.ttl
  proxied  = false
}

