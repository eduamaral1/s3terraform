provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "example-bucket" {
  bucket = "example-bucket-for-tf1111"

  tags = {
    Name        = "DemoBucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_acl" "bucket_acl" {
  bucket = aws_s3_bucket.example-bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_lifecycle_configuration" "example" {
  bucket = aws_s3_bucket.example-bucket.id

  rule {
    id = "lifecycle"

    status = "Enabled" # Specify the status of the rule

    # Add the `prefix` block to specify the objects to which the rule applies
    prefix = "teste1/"

    # Use a more descriptive `id` for the lifecycle rule
    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }

    transition {
      days          = 60
      storage_class = "GLACIER"
    }

    expiration {
      days = 90
    }
  }
}


resource "aws_s3_bucket_object" "object" {
  bucket = "example-bucket-for-tf1111"
  key    = "teste1/requirement.txt"
  source = "/home/eduardo/terraform/requirement.txt"

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  etag = filemd5("/home/eduardo/terraform/requirement.txt")
}

resource "aws_s3_bucket_policy" "example_policy" {
  bucket = aws_s3_bucket.example-bucket.id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "DenyInsecureAccess",
      "Effect": "Deny",
      "Principal": "*",
      "Action": [
        "s3:*"
      ],
      "Resource": "arn:aws:s3:::${aws_s3_bucket.example-bucket.id}/*",
      "Condition": {
        "Bool": {
          "aws:SecureTransport": "false"
        }
      }
    }
  ]
}
EOF
}
