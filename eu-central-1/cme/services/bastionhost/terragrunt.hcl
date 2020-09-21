terraform {
  #source = "git::https://git-codecommit.eu-central-1.amazonaws.com/v1/repos/terraform-aws-module-ocp3//ocp3?ref=v0.0.10"
  source = "../../../../../terraform-aws-module-autoscaling//autoscaling?ref=bastion-autoscaling"
}

include {
  path = find_in_parent_folders()
}

dependency "vpc" {
  config_path = "../../vpc"
}

inputs = {

  tags = {
    Owner       = "Infrastructure Services"
    Customer    = "TCC"
    Environment = "CME"
    Project     = "EPIC AWS Cloud Infrastructure Readiness"
  }

  tag-asg-name                    = "deployment"
  tag-asg-environment             = "cme"
  tag-asg-namespace               = "ec1"
 
  #vpc_id = dependency.vpc.outputs.vpc_id
  #efs_fs_id = dependency.efs.outputs.deployment_service_filesystem_id
  #efs_sgr_id = dependency.efs.outputs.deployment_service_security_group_id
  #internal_subnet_suffix_ag = "frontend"

}
