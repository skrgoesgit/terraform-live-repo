terraform {
  source = "git::https://git-codecommit.eu-central-1.amazonaws.com/v1/repos/terraform-aws-module-vpc//vpc?ref=v1.0.8"
}

include {
  path = find_in_parent_folders()
}

inputs = {

  tags = {
    Owner       = "Infrastructure Services"
    Customer    = "TCC"
    Environment = "ACE"
    Name        = "vpc-ew1-ace"
    Project     = "EPIC AWS Cloud Infrastructure Readiness"
  }

  ############################################
  # VPC settings

  vpc_name                            = "vpc-ew1-ace"
  vpc_cidr                            = "10.2.0.0/16"
  vpc_environment_code                = "ace"
  vpc_enable_dns_hostnames            = true
  vpc_enable_dns_support              = true

  create_internet_gateway             = true
  enable_nat_gateway                  = true
  create_database_subnet_group        = true

  enable_tgw_vpc_attachment           = true
  tgw_id                              = "tgw-0c4ca4164a545a313"
  tgw_additional_routed_vpc_cidr      = [
                                          "172.16.0.0/16",
                                          "10.121.0.0/16"
                                        ]

  region_code                         = "ew1"
  region_code_long                    = "eu-west-1"

  azs                                 = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  azs_code                            = ["ew1-1a", "ew1-1b", "ew1-1c"]

  r53_private_zone_name               = "ace.tcc.aws.internal"
  r53_private_zone_comment            = "ACE"

  r53_resolver_inbound_endpoint_name  = "r53rslv-ew1-ace-ep-in"
  r53_resolver_outbound_endpoint_name = "r53rslv-ew1-ace-ep-out"
  r53_resolver_secgrp_name            = "sgr-ew1-ace-r53rslv"

  r53_resolver_rules                  = { 
                                          "r53rslv-rule-ace-to-cme"        = [ [ "10.121.15.8", "10.121.16.8", "10.121.17.8" ], "cme.tcc.aws.internal" ],
                                          "r53rslv-rule-ace-to-cme-ad"     = [ [ "172.16.9.8",  "172.16.10.8"                ], "roadcharging.services" ],
                                          "r53rslv-rule-ace-to-tcc-at-pxm" = [ [ "10.121.15.8", "10.121.16.8", "10.121.17.8" ], "tcc.aa" ],
                                        }

  ############################################
  # Subnet settings

  public_subnet_suffix   = "public"
  public_subnets         = ["10.2.0.0/24", "10.2.1.0/24", "10.2.2.0/24"]

  frontend_subnet_suffix = "frontend"
  frontend_subnets       = ["10.2.3.0/24", "10.2.4.0/24", "10.2.5.0/24"]

  app_subnet_suffix      = "app"
  app_subnets            = ["10.2.6.0/23", "10.2.8.0/23", "10.2.10.0/23"]

  db_subnet_suffix       = "db"
  db_subnets             = ["10.2.12.0/24", "10.2.13.0/24", "10.2.14.0/24"]

  internal_subnet_suffix = "internal"
  internal_subnets       = ["10.2.15.0/24", "10.2.16.0/24", "10.2.17.0/24"]

  ecs_subnet_suffix      = "ecs"
  ecs_subnets            = ["10.2.20.0/22", "10.2.24.0/22", "10.2.28.0/22"]

  eks_subnet_suffix      = "eks"
  eks_subnets            = ["10.2.32.0/21", "10.2.40.0/21", "10.2.48.0/21"]

  ocp3_subnet_suffix     = "ocp3"
  ocp3_subnets           = ["10.2.56.0/22", "10.2.60.0/22", "10.2.64.0/22"]

}
