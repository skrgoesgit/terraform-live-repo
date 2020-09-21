terraform {
  source = "git::https://git-codecommit.eu-central-1.amazonaws.com/v1/repos/terraform-aws-module-instance//instance/?ref=v0.0.1"
  #source = "../../../../../../tcc-terraform/terraform-aws-module-instance//instance"
}

include {
  path = find_in_parent_folders()
}

dependency "vpc" {
  config_path = "../../vpc"
}

inputs = {
  source                      = "../../"

  tags = {
    Owner       = "Infrastructure Services"
    Customer    = "TCC" 
    Environment = "DCE"
    Project     = "EPIC AWS Cloud Infrastructure Readiness"
  }
  tag_namespace = "ew1-1a-dce"

  instance_enabled              = true
  instance_name                 = "sc-appsrv"
  instance_count                = 1

  ssh_key_pair_name             = "sshkey-tcc-dce-ec2lx"
  region                        = "eu-west-1"                                   #Needet to create the public and  private DNS-Host names
  availability_zones            = ["eu-west-1a"]                                #,"eu-west-1c","eu-west-1b"
  subnets                       = [dependency.vpc.outputs.app_subnet_ids[0]]    #, dependency.vpc.outputs.app_subnet_ids[1]
  vpc_id                        = dependency.vpc.outputs.vpc_id                 #Needed to create the default sequrity group
  #subnet                       = dependency.vpc.outputs.app_subnet_ids[1]
  create_default_security_group = true                                          #A new sq will be generated, if false you must prepare a list with availble groups

  ami                           = "ami-045b6bf4dbb849025"                       #RHEL-BASE-8.2-2020.07.15.160310
  assign_eip_address            = false                                         #If true a eip will be generated as the public IPv4-Adress
  associate_public_ip_address   = false
  additional_ips_count          = 0                                             #Here you can define the count of the required eips.
  instance_type                 = "t2.medium"
  allowed_ports                 = ["22", "80"]

  root_volume_type              = "gp2"
  root_volume_size              = 50
  
  ebs_volume_type               = "gp2"
  ebs_volume_size               = 50
  ebs_volume_count              = 0
}
