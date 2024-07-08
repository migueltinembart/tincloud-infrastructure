data "cloudflare_api_token_permission_groups" "all" {}

resource "cloudflare_pages_project" "development-environment" {
  account_id        = var.account_id
  name              = "development-environment"
  production_branch = "main"
}

resource "cloudflare_pages_domain" "docs_dev-env" {
  account_id   = var.account_id
  project_name = cloudflare_pages_project.development-environment.name
  domain       = "docs.dev-env.tincloud.tech"
}

resource "cloudflare_record" "docs_dev-env" {
  zone_id = cloudflare_zone.tincloud_tech.id
  name    = cloudflare_pages_domain.docs_dev-env.domain
  value   = cloudflare_pages_project.development-environment.subdomain
  type    = "CNAME"
  ttl     = 1
  proxied = true
}

resource "cloudflare_api_token" "development-environment" {
  name = "development-environment"

  policy {
    permission_groups = [
      data.cloudflare_api_token_permission_groups.all.account["Pages Write"]
    ]
    resources = {
      "com.cloudflare.api.account.${var.account_id}" = "*"
    }
  }

}