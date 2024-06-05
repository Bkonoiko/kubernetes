
module "vpc" {
  source = "./vpc"
  cidr_block = "192.168.0.0/16"
  cidr_block_sub1 = "192.168.1.0/24"
  cidr_block_sub2 = "192.168.2.0/24"
  az_s1 = "us-east-1a"
  az_s2 = "us-east-1b"
  route_cidr_block = "0.0.0.0/0"
}

module "lt_sg" {
  source = "./lt_sg"
  vpc_id = module.vpc.vpc_id
  sg_name = "tfsg"
  lt_name = "cluster_lt"

  depends_on = [ module.vpc ]
}

module "eks" {
  source = "./eks"
  subnet1 = module.vpc.subnet1
  subnet2 = module.vpc.subnet2
  sg_name = module.lt_sg.sg
  lt_id = module.lt_sg.launch_template_id
  lt_ver = module.lt_sg.launch_template_lat_ver
  desired_size = 4
  max_size = 5
  min_size = 1

  depends_on = [ module.lt_sg ]
}