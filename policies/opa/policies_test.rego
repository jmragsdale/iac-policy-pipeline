# Unit tests for the deny rules, run by `conftest verify`.

package main

import rego.v1

secure_bucket := {"resource": {
	"aws_s3_bucket": {"secure": [{"bucket": "b"}]},
	"aws_s3_bucket_acl": {"secure": [{"acl": "private", "bucket": "${aws_s3_bucket.secure.id}"}]},
	"aws_s3_bucket_public_access_block": {"secure": [{
		"bucket": "${aws_s3_bucket.secure.id}",
		"block_public_acls": true,
		"block_public_policy": true,
		"ignore_public_acls": true,
		"restrict_public_buckets": true,
	}]},
}}

secure_account := {"resource": {
	"azurerm_storage_account": {"secure": [{"allow_nested_items_to_be_public": false}]},
	"azurerm_storage_container": {"secure": [{"container_access_type": "private"}]},
}}

test_compliant_bucket_passes if {
	count(deny) == 0 with input as secure_bucket
}

test_compliant_account_passes if {
	count(deny) == 0 with input as secure_account
}

test_public_acl_is_denied if {
	input_doc := {"resource": {"aws_s3_bucket_acl": {"open": [{"acl": "public-read"}]}}}
	count(deny) == 1 with input as input_doc
}

test_disabled_public_access_guard_is_denied if {
	input_doc := {"resource": {"aws_s3_bucket_public_access_block": {"open": [{
		"bucket": "${aws_s3_bucket.open.id}",
		"block_public_acls": false,
		"block_public_policy": true,
		"ignore_public_acls": true,
		"restrict_public_buckets": true,
	}]}}}
	count(deny) == 1 with input as input_doc
}

test_bucket_without_public_access_block_is_denied if {
	input_doc := {"resource": {"aws_s3_bucket": {"lonely": [{"bucket": "b"}]}}}
	count(deny) == 1 with input as input_doc
}

test_public_container_is_denied if {
	input_doc := {"resource": {"azurerm_storage_container": {"open": [{"container_access_type": "container"}]}}}
	count(deny) == 1 with input as input_doc
}

test_account_defaulting_to_public_is_denied if {
	input_doc := {"resource": {"azurerm_storage_account": {"silent": [{"account_tier": "Standard"}]}}}
	count(deny) == 1 with input as input_doc
}
