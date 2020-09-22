terraform {
  source = "git::https://github.com/skruegergoesgit/terraform-aws-module-ec2//ec2?ref=v0.0.1"
}

include {
  path = find_in_parent_folders()
}

dependency "vpc" {
  config_path = "../../vpc"
}

inputs = {
  vpc_id           = dependency.vpc.outputs.vpc_id
  subnet_id        = dependency.vpc.outputs.app_subnet_ids
  ami_id           = "ami-0823c236601fef765"
  instance_type    = "t2.micro"
  ssh_key_name     = "sshkey-tcc-ace-ec2lx"
  iam_role_name    = ""
  secgrp_name      = "fw-demo"
  enabled_fw_ports = [ "22" ]
}
