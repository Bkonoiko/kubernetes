output "sg" {
  value = aws_security_group.tfsg.id
}

output "launch_template_id" {
  value = aws_launch_template.cluster_lt.id
}

output "launch_template_lat_ver" {
  value = aws_launch_template.cluster_lt.latest_version
}