resource "aws_cloudfront_origin_access_identity" "default" {
  comment = "${var.comment}"
}

data "aws_iam_policy_document" "origin" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["arn:aws:s3:::$${bucket_name}$${origin_path}*"]

    principals {
      type        = "AWS"
      identifiers = ["${aws_cloudfront_origin_access_identity.default.iam_arn}"]
    }
  }

  statement {
    actions   = ["s3:ListBucket"]
    resources = ["arn:aws:s3:::$${bucket_name}"]

    principals {
      type        = "AWS"
      identifiers = ["${aws_cloudfront_origin_access_identity.default.iam_arn}"]
    }
  }
}

data "template_file" "default" {
  template = "${data.aws_iam_policy_document.origin.json}"

  vars {
    origin_path = "${coalesce(var.origin_path, "/")}"
    bucket_name = "${var.bucket}"
  }
}

resource "aws_s3_bucket_policy" "default" {
  bucket = "${var.bucket}"
  policy = "${data.template_file.default.rendered}"
}

resource "aws_s3_bucket" "origin" {
  bucket        = "${var.bucket}"
  acl           = "private"
  force_destroy = "${var.origin_force_destroy}"
  region        = "eu-west-1"

  cors_rule {
    allowed_headers = "${var.cors_allowed_headers}"
    allowed_methods = "${var.cors_allowed_methods}"
    allowed_origins = "${sort(distinct(compact(concat(var.cors_allowed_origins, var.cloudfront_aliases))))}"
    expose_headers  = "${var.cors_expose_headers}"
    max_age_seconds = "${var.cors_max_age_seconds}"
  }
}

resource "aws_cloudfront_distribution" "default" {
  enabled             = "${var.enabled}"
  is_ipv6_enabled     = "${var.is_ipv6_enabled}"
  comment             = "${var.comment}"
  price_class         = "${var.price_class}"

  aliases = ["${var.cloudfront_aliases}"]

  origin {
    domain_name = "${aws_s3_bucket.origin.bucket_regional_domain_name}"
    origin_id   = "${var.service_name}-${var.Environment}"
    origin_path = "${var.origin_path}"
    s3_origin_config {
      origin_access_identity = "${aws_cloudfront_origin_access_identity.default.cloudfront_access_identity_path}"
    }
  }

  viewer_certificate {
    acm_certificate_arn            = "${var.acm_certificate_arn}"
    ssl_support_method             = "sni-only"
    minimum_protocol_version       = "${var.minimum_protocol_version}"
    cloudfront_default_certificate = "${var.acm_certificate_arn == "" ? true : false}"
  }

  default_cache_behavior {
    allowed_methods  = "${var.allowed_methods}"
    cached_methods   = "${var.cached_methods}"
    target_origin_id = "${var.service_name}-${var.Environment}"
    compress         = "${var.compress}"

    forwarded_values {
      query_string = "${var.forward_query_string}"
      headers      = ["${var.forward_header_values}"]

      cookies {
        forward = "${var.forward_cookies}"
      }
    }

    viewer_protocol_policy = "${var.viewer_protocol_policy}"

    lambda_function_association {
      event_type = "viewer-request"
      lambda_arn = "${aws_lambda_function.basic-auth-function.qualified_arn}"
    }
    default_ttl            = "${var.default_ttl}"
    min_ttl                = "${var.min_ttl}"
    max_ttl                = "${var.max_ttl}"
  }

  restrictions {
    geo_restriction {
      restriction_type = "${var.geo_restriction_type}"
      locations        = "${var.geo_restriction_locations}"
    }
  }

  custom_error_response = ["${var.custom_error_response}"]
}
