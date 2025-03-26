provider "aws" {
  region = "eu-west-1" # Change to your preferred region
}

# S3 bucket for static content
resource "aws_s3_bucket" "public_bucket" {
  bucket = "binq-co-uk"
  acl = "private"
}

resource "aws_s3_bucket" "private_bucket" {
  bucket = "crm-binq-co-uk"
  acl = "private"
}

locals {
  s3_origin_id = "myS3Origin"
}

# CloudFront distribution for public site
resource "aws_cloudfront_distribution" "public_cdn" {
  origin {
    domain_name = aws_s3_bucket.public_bucket.bucket_domain_name
    origin_id   = "S3-binq-co-uk"
    s3_origin_config {
      origin_access_identity = "origin-access-identity/cloudfront/E3RGR3EXAMPLE"
    }
  }

  enabled             = true
  default_root_object = "index.html"

  default_cache_behavior {
    target_origin_id       = "S3-binq-co-uk"
    viewer_protocol_policy = "redirect-to-https"
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn = "arn:aws:acm:eu-west-1:your-account-id:certificate/your-cert-id"
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }
}

# CloudFront distribution for private intranet (API Gateway integration)
resource "aws_cloudfront_distribution" "private_cdn" {
  origin {
    domain_name = "your-api-gateway-id.execute-api.eu-west-1.amazonaws.com"
    origin_id   = "API-Gateway-Origin"
    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "https-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  enabled             = true
  default_root_object = "index.html"

  default_cache_behavior {
    target_origin_id       = "API-Gateway-Origin"
    viewer_protocol_policy = "redirect-to-https"
    allowed_methods        = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
    cached_methods         = ["GET", "HEAD"]
    forwarded_values {
      query_string = true
      cookies {
        forward = "all"
      }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn = "arn:aws:acm:eu-west-1:your-account-id:certificate/your-cert-id"
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }
}
