terraform {
  #source = "git::https://git-codecommit.eu-central-1.amazonaws.com/v1/repos/terraform-aws-module-rds//database?ref=v0.0.10"
  source = "../../../../../../terraform-aws-module-rds/database"
}

include {
  path = find_in_parent_folders()
}

dependency "vpc" {
  #config_path = "../../vpc"
  config_path = "../../../vpc"
}


inputs = {
    rds_vpc_id                                  = dependency.vpc.outputs.vpc_id
    rds_identifier                              = "acesc"
    rds_engine                                  = "oracle-ee"
    rds_engine_version                          = "12.1.0.2.v19"
    rds_instance_class                          = "db.m4.large"
    rds_allocated_storage                       = 500
    rds_storage_encrypted                       = true
    rds_port                                    = "1521"
    rds_kms_key_id                              = "arn:aws:kms:eu-west-1:918691468795:key/e3d30d05-f3d1-4180-8301-9a5f3d2b70d4"
    rds_license_model                           = "bring-your-own-license"
    rds_name                                    = "acesc"
    #rds_username                                = "oraadm"
    #rds_password                                = "Blank123"
    rds_vpc_security_group_ids                  = ["sg-025d94415b0a891fe"]
    rds_iam_database_authentication_enabled     = false
    rds_availability_zone                       = "eu-west-1a"
    rds_parameter_group_name                    = "default.oracle-ee-12.1"
    rds_option_group_name                       = "default:oracle-ee-12-1"
    rds_db_subnet_group_name                    = "sng-ew1-ace-db"
    rds_family                                  = "oracle-ee-12.1"
    rds_maintenance_window                      = "Mon:00:00-Mon:03:00"
    rds_backup_window                           = "03:00-06:00"
    rds_backup_retention_period                 = 1
    rds_major_engine_version                    = "12.1"
    rds_character_set_name                      = "AL32UTF8"
    rds_deletion_protection                     = false
    rds_final_snapshot_identifier               = "acesc"
    rds_secgrp_name                             = "sgr-ew1-ace-db-ora-sc"
    rds_cidr_blocks                             = ["172.16.0.0/24"]
    rds_secret_name                             = "acpw-tcc-dce-db-ora-sc"
    rds_option_group_name                       = "optgrp-tcc-ace-db-ora-sc"
    rds_optgrp_create                           = true
    rds_parameter_group_name                    = "pargrp-tcc-ace-db-ora-sc"
    rds_pargrp_create                           = true
}
