resource "aws_s3_bucket" "1stbucket" {
  bucket = var.bucketName
}

resource "aws_s3_bucket_acl" "1stbucket" {
  bucket = aws_s3_bucket.1stbucket.id
  acl    = var.aclType
}

resource "aws_s3_object" "1stbucket" {
	bucket = aws_s3_bucket.1stbucket.id
	key = var.objectKey
}

resource "aws_s3_bucket_policy" "bucket_policy" {
	bucket = aws_s3_bucket.1stbucket.id

	policy = <<POLICY
{
"Version": "2012-10-17",
"Statement": [
{
"Sid": "PublicReadGetObject",
"Effect": "Allow",
"Principal": "*",
"Action": "s3.GetObject",
"Resource": "arn:aws:s3:::1stbucket/*"
}
]
}
POLICY
}

data "aws_iam_policy_document" "allow_access_from_another_account" {
	statement {
		principals {
			type = var.policyDocPrincipalsType
			identifiers = var.policyDocPrincipalsIdentifiers
			}
		actions = var.policyDocPrincipalsActions

		resources = [
		aws_s3_bucket.1stbucket.arn,
		"${aws_s3_bucket.1stbucket.arn}/*",
		]
	}
}

resource "aws_s3_bucket_website_configuration" "1stbucket" {
	bucket = aws_s3_bucket.1stbucket.bucket

	index_document{
	suffix = var.indexWebFile
	}

	error_document{
		key = var.errorWebFile
	}

	routing_rules = <<EOF
	[{
		"Condition": {
			"KeyPrefixEquals": "docs/"
	},
	"Redirect": {
		"ReplaceKeyPrefixWith": ""
	}
}]
EOF

}
