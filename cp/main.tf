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
  key    = "user_events.csv"
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
    path = "s3://${aws_s3_bucket.cp-s3.id}"
  }

  configuration = jsonencode({
    Version = 1.0,
    CrawlerOutput = {
      Partitions = { AddOrUpdateBehavior = "InheritFromTable" }
    }
  })

  schedule = null  # on-demand; remove or change to run automatically
}

resource "aws_glue_catalog_table" "user_events" {
  name          = "user_events"
  database_name = aws_glue_catalog_database.cp_data_lake_db.name
  table_type    = "EXTERNAL_TABLE"

  parameters = {
    "classification" = "csv"
    "compressionType" = "none"
    "typeOfData" = "file"
  }

  storage_descriptor {
    columns {
      name = "user_id"
      type = "string"
    }
    columns {
      name = "event_type"
      type = "string"
    }
    columns {
      name = "event_timestamp"
      type = "string"
    }
    location      = "s3://${aws_s3_bucket.cp-s3.id}/user_events.csv"
    input_format  = "org.apache.hadoop.mapred.TextInputFormat"
    output_format = "org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat"
    ser_de_info {
      name                  = "user_events"
      serialization_library = "org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe"
      parameters = {
        "field.delim" = ","
        "skip.header.line.count" = "1"
      }
    }
  }
}

