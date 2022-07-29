variable "region" {
  description = "The name of the SNS topic to create"
  type        = string
  default     = "us-east-1"
}

variable "s3_bucket_name" {
  description = "The name of the SNS topic to create"
  type        = string
  default     = "demo-bucket-val"
}

variable "sns_topic_name" {
  description = "The name of the SNS topic to create"
  type        = string
  default     = "s3-event-notification-sns-topic"
}

variable "sns_topic_subscription_protocol" {
  description = "The name of the SNS topic to create"
  type        = string
  default     = "email"
}

variable "sns_topic_subscription_endpoint" {
  description = "The name of the SNS topic to create"
  type        = string
  default     = "valentino.joseph27@gmail.com "
}