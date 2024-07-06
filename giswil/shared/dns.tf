resource "maas_dns_domain" "domain" {
  for_each      = var.domains
  name          = each.value
  is_default    = each.value == "giswil.tincloud.local" ? true : false
  authoritative = true
}