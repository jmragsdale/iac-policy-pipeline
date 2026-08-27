# Rejects S3 configurations that expose objects to the public internet.
# Input is Terraform HCL parsed by conftest, so every resource block arrives as
# input.resource[<type>][<name>][<index>].

package main

import rego.v1

acls_granting_public_access := {"public-read", "public-read-write"}

public_access_guards := {
	"block_public_acls",
	"block_public_policy",
	"ignore_public_acls",
	"restrict_public_buckets",
}

deny contains msg if {
	some name, i
	acl := input.resource.aws_s3_bucket_acl[name][i]
	acl.acl in acls_granting_public_access
	msg := sprintf("aws_s3_bucket_acl.%s sets acl = %q; S3 objects must not be world-readable", [name, acl.acl])
}

# A public access block that leaves any of its four guards off (or unset) is the
# most common way a bucket ends up reachable, so check the value explicitly
# rather than checking only that the block exists.
deny contains msg if {
	some name, i
	pab := input.resource.aws_s3_bucket_public_access_block[name][i]
	some guard in public_access_guards
	value := object.get(pab, guard, "unset")
	value != true
	msg := sprintf(
		"aws_s3_bucket_public_access_block.%s has %s = %v; all four public-access guards must be true",
		[name, guard, value],
	)
}

# A bucket with no public access block at all is public by omission.
deny contains msg if {
	some name
	input.resource.aws_s3_bucket[name]
	not has_public_access_block(name)
	msg := sprintf("aws_s3_bucket.%s has no aws_s3_bucket_public_access_block", [name])
}

has_public_access_block(bucket) if {
	some name, i
	pab := input.resource.aws_s3_bucket_public_access_block[name][i]
	contains(pab.bucket, sprintf("aws_s3_bucket.%s.", [bucket]))
}
