terraform {
 source = "git::https://git-codecommit.eu-central-1.amazonaws.com/v1/repos/terraform-aws-module-efs-service//efs-service?ref=v0.0.1"
 #source = "../../../../../tcc-terraform/terraform-aws-module-efs-service//efs-service"
}

include {
  path = find_in_parent_folders()
}

dependency "vpc" {
  config_path = "../vpc"
}

inputs = {

  tags = {
    Owner       = "Infrastructure Services"
    Customer    = "TCC"
    Environment = "CME"
    Name        = "vpc-ec1-cme"
    Project     = "EPIC AWS Cloud Infrastructure Readiness"
  }

  vpc_id        = dependency.vpc.outputs.vpc_id
  subnets       = dependency.vpc.outputs.internal_subnet_ids  
  region        = "eu-west-1"
}
