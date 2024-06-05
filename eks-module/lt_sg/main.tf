// Security Group
resource "aws_security_group" "tfsg" {
  name        = var.sg_name
  description = "SG for eks"
  vpc_id      = var.vpc_id

  ingress {
    description = "ALL"
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "ALL"
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}


#launch template for node group
resource "aws_launch_template" "cluster_lt" {
  name = var.lt_name
  vpc_security_group_ids = [ aws_security_group.tfsg.id ]
  depends_on = [ aws_security_group.tfsg ]
}

