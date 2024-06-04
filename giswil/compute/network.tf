resource "maas_dns_domain" "tincloud-domain-name" {
  name          = "giswil.tincloud.local"
  authoritative = true
  ttl           = 3600
  is_default    = true

}

resource "maas_fabric" "maas_fabrics" {
  name = var.fabric.name
}

# can be imported
resource "maas_resource_pool" "maas_pools" {
  name = var.pool.name
}

resource "maas_vlan" "maas_vlans" {
  for_each = var.subnets
  fabric   = maas_fabric.fabric-1.id
  name     = each.key
  vid      = each.value["vlan_id"]
}

resource "maas_subnet" "tf_subnet" {
  for_each    = var.subnets
  cidr        = each.value["cidr"]
  fabric      = maas_fabric.fabric-1.id
  vlan        = each.value["vlan_id"]
  name        = each.key
  gateway_ip  = each.value["gateway"]
  dns_servers = each.value["dns_servers"]

  dynamic "ip_ranges" {
    for_each = each.value["dhcp_ranges"]
    content {
      type     = ip_ranges.value["type"]
      start_ip = ip_ranges.value["start_ip"]
      end_ip   = ip_ranges.value["end_ip"]
    }
  }
}

