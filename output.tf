output "alb_dns_name" {
  value = module.alb.samrdaymond_wa_alb_dns_name
}

output "alb_targetgroup_arn" {
  value = module.alb.samrdaymond_wa_aws_alb_tg_arn
}

output "ecs_task_arn" {
  value = module.ecs.samrdaymond_wa_ecs_task_arn
}