#Immutable variables
variable "service_name" {}

variable "Environment" {}

#Common variables
variable "acm_certificate_arn" {}

variable "route53_zone_id" {}
variable "cloudfront_cname" {}

variable "enabled" {
  default     = "true"
  description = "Select Enabled if you want CloudFront to begin processing requests as soon as the distribution is created, or select Disabled if you do not want CloudFront to begin processing requests after the distribution is created."
}

variable "minimum_protocol_version" {
  description = "Cloudfront TLS minimum protocol version"
  default     = "TLSv1.2_2018"
}

variable "cloudfront_aliases" {
  type        = "list"
  description = "List of FQDN's - Used to set the Alternate Domain Names (CNAMEs) setting on Cloudfront"
  default     = []
}

variable "origin_path" {
  description = "When set, will cause CloudFront to request your content from a directory in your Amazon S3 bucket or your custom origin. It must begin with a `/`. Do not add a `/` at the end of the path."
  default     = ""
}

variable "bucket" {
  default     = ""
  description = "Name of S3 bucket"
}

variable "origin_force_destroy" {
  default     = "false"
  description = "Delete all objects from the bucket  so that the bucket can be destroyed without error (e.g. `true` or `false`)"
}

variable "compress" {
  default     = "true"
  description = "Compress content for web requests that include Accept-Encoding: gzip in the request header"
}

variable "is_ipv6_enabled" {
  default     = "true"
  description = "State of CloudFront IPv6"
}

variable "comment" {
  default     = "Distribution for article upload tools"
  description = "Comment for the origin access identity"
}

variable "forward_query_string" {
  default     = "false"
  description = "Forward query strings to the origin that is associated with this cache behavior"
}

variable "forward_cookies" {
  default     = "none"
  description = "Time in seconds that browser can cache the response for S3 bucket"
}

variable "forward_header_values" {
  type        = "list"
  description = "A list of whitelisted header values to forward to the origin"
  default     = ["Access-Control-Request-Headers", "Access-Control-Request-Method", "Origin"]
}

variable "price_class" {
  default     = "PriceClass_All"
  description = "Price class for this distribution: `PriceClass_All`, `PriceClass_200`, `PriceClass_100`"
}

variable "viewer_protocol_policy" {
  description = "allow-all, redirect-to-https"
  default     = "allow-all"
}

variable "allowed_methods" {
  type        = "list"
  default     = ["GET", "HEAD"]
  description = "List of allowed methods (e.g. GET, PUT, POST, DELETE, HEAD) for AWS CloudFront"
}

variable "cached_methods" {
  type        = "list"
  default     = ["GET", "HEAD"]
  description = "List of cached methods (e.g. GET, PUT, POST, DELETE, HEAD)"
}

variable "default_ttl" {
  default     = "3600"
  description = "Default amount of time (in seconds) that an object is in a CloudFront cache"
}

variable "min_ttl" {
  default     = "1800"
  description = "Minimum amount of time that you want objects to stay in CloudFront caches"
}

variable "max_ttl" {
  default     = "86400"
  description = "Maximum amount of time (in seconds) that an object is in a CloudFront cache"
}

variable "geo_restriction_type" {
  default     = "none"
  description = "Method that use to restrict distribution of your content by country: `none`, `whitelist`, or `blacklist`"
}

variable "geo_restriction_locations" {
  type        = "list"
  default     = []
  description = "List of country codes for which  CloudFront either to distribute content (whitelist) or not distribute your content (blacklist)"
}

variable "custom_error_response" {
  description = "List of one or more custom error response element maps"
  type        = "list"
  default     = []
}

variable "cors_allowed_headers" {
  type        = "list"
  default     = ["*"]
  description = "List of allowed headers for S3 bucket"
}

variable "cors_allowed_methods" {
  type        = "list"
  default     = ["GET"]
  description = "List of allowed methods (e.g. GET, PUT, POST, DELETE, HEAD) for S3 bucket"
}

variable "cors_allowed_origins" {
  type        = "list"
  default     = []
  description = "List of allowed origins (e.g. example.com, test.com) for S3 bucket"
}

variable "cors_expose_headers" {
  type        = "list"
  default     = ["ETag"]
  description = "List of expose header in the response for S3 bucket"
}

variable "cors_max_age_seconds" {
  default     = "3600"
  description = "Time in seconds that browser can cache the response for S3 bucket"
}
