resource "azurecaf_name" "frontdoor_profile" {
  name          = var.stack
  resource_type = "azurerm_cdn_frontdoor_profile"
  prefixes      = var.name_prefix == "" ? null : [local.name_prefix]
  suffixes      = compact([var.client_name, var.environment, local.name_suffix, var.use_caf_naming ? "" : "fdp"])
  use_slug      = var.use_caf_naming
  clean_input   = true
  separator     = "-"
}

resource "azurecaf_name" "frontdoor_endpoint" {
  for_each = { for endpoint in var.endpoints : endpoint.name => endpoint }

  name          = var.stack
  resource_type = "azurerm_cdn_frontdoor_endpoint"
  prefixes      = coalesce(compact([local.name_prefix, each.value.prefix]))
  suffixes      = compact([var.client_name, var.environment, local.name_suffix, each.value.name, var.use_caf_naming ? "" : "fde"])
  use_slug      = var.use_caf_naming
  clean_input   = true
  separator     = "-"
}

resource "azurecaf_name" "frontdoor_origin_group" {
  for_each = { for origin_group in var.origin_groups : origin_group.name => origin_group }

  name          = var.stack
  resource_type = "azurerm_cdn_frontdoor_origin_group"
  prefixes      = var.name_prefix == "" ? null : [local.name_prefix]
  suffixes      = compact([var.client_name, var.environment, local.name_suffix, each.value.name, var.use_caf_naming ? "" : "fdog"])
  use_slug      = var.use_caf_naming
  clean_input   = true
  separator     = "-"
}

resource "azurecaf_name" "frontdoor_origin" {
  for_each = { for origin in var.origins : origin.name => origin }

  name          = var.stack
  resource_type = "azurerm_cdn_frontdoor_origin"
  prefixes      = var.name_prefix == "" ? null : [local.name_prefix]
  suffixes      = compact([var.client_name, var.environment, local.name_suffix, each.value.name, var.use_caf_naming ? "" : "fdo"])
  use_slug      = var.use_caf_naming
  clean_input   = true
  separator     = "-"
}

resource "azurecaf_name" "frontdoor_custom_domain" {
  for_each = { for custom_domain in var.custom_domains : custom_domain.name => custom_domain }

  name          = var.stack
  resource_type = "azurerm_cdn_frontdoor_profile" #azurerm_cdn_frontdoor_custom_domain not available yet

  prefixes    = compact([var.use_caf_naming ? "fdcd" : "", local.name_prefix])
  suffixes    = compact([var.client_name, var.environment, local.name_suffix, each.value.name, var.use_caf_naming ? "" : "fdcd"])
  use_slug    = false
  clean_input = true
  separator   = "-"
}

resource "azurecaf_name" "frontdoor_route" {
  for_each = { for route in var.routes : route.name => route }

  name          = var.stack
  resource_type = "azurerm_cdn_frontdoor_profile" #azurerm_cdn_frontdoor_route not available yet

  prefixes    = compact([var.use_caf_naming ? "fdr" : "", local.name_prefix])
  suffixes    = compact([var.client_name, var.environment, local.name_suffix, each.value.name, var.use_caf_naming ? "" : "fdr"])
  use_slug    = false
  clean_input = true
  separator   = "-"
}

resource "azurecaf_name" "frontdoor_rule_set" {
  for_each = { for rule_set in var.rule_sets : rule_set.name => rule_set }

  name          = var.stack
  resource_type = "azurerm_cdn_frontdoor_rule_set"

  prefixes    = var.name_prefix == "" ? null : [local.name_prefix]
  suffixes    = compact([var.client_name, var.environment, local.name_suffix, each.value.name, var.use_caf_naming ? "" : "fdrs"])
  use_slug    = var.use_caf_naming
  clean_input = true
  separator   = "-"
}

resource "azurecaf_name" "frontdoor_rule" {
  for_each = { for rule in local.rules : format("%s-%s", rule.rule_set_name, rule.name) => rule }

  name          = var.stack
  resource_type = "azurerm_cdn_frontdoor_rule"

  prefixes    = var.name_prefix == "" ? null : [local.name_prefix]
  suffixes    = compact([var.client_name, var.environment, local.name_suffix, each.value.rule_set_name, each.value.name, var.use_caf_naming ? "" : "fdr"])
  use_slug    = var.use_caf_naming
  clean_input = true
  separator   = "-"
}
