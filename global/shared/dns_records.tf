resource "cloudflare_zone" "tincloud_tech" {
  account_id = var.account_id
  zone       = "tincloud.tech"
  plan       = "free"
}

resource "cloudflare_zone_dnssec" "tincloud_tech" {
  zone_id = cloudflare_zone.tincloud_tech.id
}
