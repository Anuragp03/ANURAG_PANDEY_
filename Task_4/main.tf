provider "aws" {
  region = "eu-north-1"
}

resource "aws_sns_topic" "billing_alert" {
  name = "ANURAG_PANDEY_Billing_Alerts"
}

resource "aws_cloudwatch_metric_alarm" "billing" {
  alarm_name          = "ANURAG_PANDEY_Billing_Alarm_Over_100INR"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "EstimatedCharges"
  namespace           = "AWS/Billing"
  period              = "21600"
  statistic           = "Maximum"
  threshold           = "1.2" 
  alarm_description   = "Alarm when AWS charges exceed $1.20 (approx 100 INR)"
  dimensions = {
    Currency = "USD"
  }
  alarm_actions = [aws_sns_topic.billing_alert.arn]
}