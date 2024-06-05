output "vpc_id" {
  value = aws_vpc.tfvpc.id
}

output "subnet1" {
  value = aws_subnet.tfsub1.id
}

output "subnet2" {
  value = aws_subnet.tfsub2.id
}

