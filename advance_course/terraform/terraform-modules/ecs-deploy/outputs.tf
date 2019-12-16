output "ECSService" {
  value = "${ join(" ", aws_ecs_service.ECSService.*.id) }"
}

output "ECSServiceARNWithoutLB" {
  value = "${ join(" ", aws_ecs_service.ECSServiceWithoutLB.*.id) }"
}
output "TargetGroupARN" {
  value = "${ join(" ", aws_lb_target_group.TargetGroup.*.arn) }"
}

output "TargetGroupName" {
  value = "${ join(" ", aws_lb_target_group.TargetGroup.*.name) }"
}
