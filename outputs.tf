output "alb_arn" {
  description = "ARN of the ALB"
  value       = module.alb.arn
}

output "alb_dns_name" {
  description = "DNS name of the ALB"
  value       = module.alb.dns_name
}

output "alb_zone_id" {
  description = "Route53 zone ID of the ALB"
  value       = module.alb.zone_id
}

output "target_group_arn" {
  description = "ARN of the target group"
  value       = module.target_group.arn
}

output "https_listener_arn" {
  description = "ARN of the HTTPS listener"
  value       = module.https_listener.arn
}
