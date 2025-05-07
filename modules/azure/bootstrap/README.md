<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.11.1 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | 4.22.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 4.22.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/4.22.0/docs/resources/resource_group) | resource |
| [azurerm_storage_account.sa](https://registry.terraform.io/providers/hashicorp/azurerm/4.22.0/docs/resources/storage_account) | resource |
| [azurerm_storage_container.sc](https://registry.terraform.io/providers/hashicorp/azurerm/4.22.0/docs/resources/storage_container) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_resource_group_location"></a> [resource\_group\_location](#input\_resource\_group\_location) | The Azure Region where the Resource Group should exist | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The Name which should be used for this Resource Group | `string` | n/a | yes |
| <a name="input_storage_account_kind"></a> [storage\_account\_kind](#input\_storage\_account\_kind) | Defines the Kind of account. Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2 | `string` | n/a | yes |
| <a name="input_storage_account_name"></a> [storage\_account\_name](#input\_storage\_account\_name) | Specifies the name of the storage account. Only lowercase Alphanumeric characters allowed. | `string` | n/a | yes |
| <a name="input_storage_account_replication_type"></a> [storage\_account\_replication\_type](#input\_storage\_account\_replication\_type) | Defines the type of replication to use for this storage account. Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS | `string` | n/a | yes |
| <a name="input_storage_account_tier"></a> [storage\_account\_tier](#input\_storage\_account\_tier) | Defines the Tier to use for this storage account. Valid options are Standard and Premium | `string` | n/a | yes |
| <a name="input_storage_container_access_type"></a> [storage\_container\_access\_type](#input\_storage\_container\_access\_type) | The Access Level configured for this Container. Possible values are blob, container or private | `string` | n/a | yes |
| <a name="input_storage_container_name"></a> [storage\_container\_name](#input\_storage\_container\_name) | The name of the Container which should be created within the Storage Account | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | The Name which should be used for this Resource Group |
<!-- END_TF_DOCS -->