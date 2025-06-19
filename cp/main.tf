provider "aws" {
  region = "us-east-1"
}

# wait what? really?
# "S3 bucket names must be globally unique across all AWS accounts."
resource "random_string" "suffix" {
  length  = 8
  special = false
  upper   = false
  numeric = true
}

resource "aws_s3_bucket" "cp-s3" {
  bucket = "cp-s3-bucket-${random_string.suffix.result}"
  force_destroy = true
}

resource "aws_s3_object" "user_events_csv" {
  bucket = aws_s3_bucket.cp-s3.id
  key    = "csv/user_events.csv"
  source = "user_events.csv"
  etag   = filemd5("user_events.csv")
}

resource "aws_glue_catalog_database" "cp_data_lake_db" {
  name = "cp_data_lake"
}

resource "aws_iam_role" "glue_crawler_role" {
  name = "glue-crawler-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "glue.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "glue_policy" {
  role       = aws_iam_role.glue_crawler_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"
}

resource "aws_iam_policy" "glue_s3_access" {
  name        = "glue-s3-access"
  description = "Allow Glue to access S3 bucket for crawling"
  policy      = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:GetObject",
          "s3:ListBucket"
        ],
        Resource = [
          aws_s3_bucket.cp-s3.arn,
          "${aws_s3_bucket.cp-s3.arn}/*"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "glue_s3_access_attach" {
  role       = aws_iam_role.glue_crawler_role.name
  policy_arn = aws_iam_policy.glue_s3_access.arn
}

resource "aws_glue_crawler" "csv_crawler" {
  name          = "csv-data-crawler"
  role          = aws_iam_role.glue_crawler_role.arn
  database_name = aws_glue_catalog_database.cp_data_lake_db.name

  s3_target {
    path = "s3://${aws_s3_bucket.cp-s3.id}/csv"
  }

  configuration = jsonencode({
    Version = 1.0,
    CrawlerOutput = {
      Partitions = { AddOrUpdateBehavior = "InheritFromTable" }
    }
  })

  schedule = null  # on-demand; remove or change to run automatically
}

