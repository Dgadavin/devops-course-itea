output "LaunchConfigurationId" {
  value = "${aws_launch_configuration.launch_configuration.id}"
}

output "LaunchConfigurationName" {
  value = "${aws_launch_configuration.launch_configuration.name}"
}

output "AutoscalingGroupId" {
  value = "${aws_autoscaling_group.autoscaling_group.id}"
}

output "AutoscalingGroupARN" {
  value = "${aws_autoscaling_group.autoscaling_group.arn}"
}

output "AutoscalingGroupName" {
  value = "${aws_autoscaling_group.autoscaling_group.name}"
}
