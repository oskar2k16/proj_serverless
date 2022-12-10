output "bucket_domain_name" {
	value = aws_s3_bucket.1stbucket.*.bucket_domain_name
	description = "FQDN of bucket"
}

output "bucket_website_endpoind" {
	value = aws_s3_bucket_website_configuration.1stbucket.*.website_endpoint
	description = "The bucket website endpoint, if the site is enabled"
}

output "bucket_arn" {
	value = aws_s3_bucket.1stbucket.*.arn
	description = "Bucket ARN"
}
