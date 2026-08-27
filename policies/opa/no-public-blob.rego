# Rejects Azure Storage configurations that expose blobs to anonymous readers.

package main

import rego.v1

container_access_granting_public_read := {"blob", "container"}

deny contains msg if {
	some name, i
	container := input.resource.azurerm_storage_container[name][i]
	container.container_access_type in container_access_granting_public_read
	msg := sprintf(
		"azurerm_storage_container.%s sets container_access_type = %q; blobs must not be anonymously readable",
		[name, container.container_access_type],
	)
}

# allow_nested_items_to_be_public defaults to TRUE in the azurerm provider, so
# an account that never mentions it is just as exposed as one that opts in.
deny contains msg if {
	some name, i
	account := input.resource.azurerm_storage_account[name][i]
	object.get(account, "allow_nested_items_to_be_public", true) == true
	msg := sprintf(
		"azurerm_storage_account.%s permits public nested items; set allow_nested_items_to_be_public = false",
		[name],
	)
}
