provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "s3_bucket" {
  bucket = var.s3_bucket_name
}

resource "aws_sns_topic" "sns_topic" {
  name = var.sns_topic_name

  policy     = <<POLICY
{
    "Version":"2012-10-17",
    "Id": "example-ID",
    "Statement":[{
        "Effect": "Allow",
        "Principal": { "Service": "s3.amazonaws.com" },
        "Action": "SNS:Publish",
        "Resource": "arn:aws:sns:*:*:${var.sns_topic_name}",
        "Condition":{
            "ArnLike":{"aws:SourceArn":"${aws_s3_bucket.s3_bucket.arn}"}
        }
    }]
}
POLICY
  depends_on = [aws_s3_bucket.s3_bucket]
}

resource "aws_sns_topic_subscription" "sns_topic_subscription" {
  topic_arn  = aws_sns_topic.sns_topic.arn
  protocol   = var.sns_topic_subscription_protocol
  endpoint   = var.sns_topic_subscription_endpoint
  depends_on = [aws_sns_topic.sns_topic]
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.s3_bucket.id

  topic {
    topic_arn     = aws_sns_topic.sns_topic.arn
    events        = ["s3:ObjectCreated:*"]
    filter_suffix = ".log"
  }

  topic {
    topic_arn     = aws_sns_topic.sns_topic.arn
    events        = ["s3:ObjectCreated:*"]
    filter_suffix = ".csv"
  }

  topic {
    topic_arn     = aws_sns_topic.sns_topic.arn
    events        = ["s3:ObjectCreated:*"]
    filter_suffix = ".tsv"
  }
  depends_on = [aws_sns_topic_subscription.sns_topic_subscription]
}