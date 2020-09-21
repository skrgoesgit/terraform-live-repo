terraform {
  source = "git::https://git-codecommit.eu-central-1.amazonaws.com/v1/repos/terraform-aws-module-rds//database?ref=v0.0.10"
  #source = "../../../../../../terraform-aws-module-rds/database"
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
    rds_identifier                              = "acexb"
    rds_engine                                  = "sqlserver-se"
    rds_engine_version                          = "14.00.3294.2.v1"
    rds_instance_class                          = "db.t3.xlarge"
    rds_allocated_storage                       = 500
    rds_storage_encrypted                       = true
    rds_port                                    = "1433"
    rds_kms_key_id                              = "arn:aws:kms:eu-west-1:918691468795:key/e3d30d05-f3d1-4180-8301-9a5f3d2b70d4"
    rds_license_model                           = "license-included"
    rds_name                                    = ""
    rds_vpc_security_group_ids                  = ["sg-025d94415b0a891fe"]
    rds_iam_database_authentication_enabled     = false
    rds_availability_zone                       = "eu-west-1a"
    rds_multi_az                                = false
    rds_parameter_group_name                    = "default.sqlserver-se-14.0"
    rds_option_group_name                       = "default:sqlserver-se-14-00"
    rds_db_subnet_group_name                    = "sng-ew1-ace-db"
    #rds_family                                  = "14.00"
    rds_maintenance_window                      = "Mon:00:00-Mon:03:00"
    rds_backup_window                           = "03:00-06:00"
    rds_backup_retention_period                 = 1
    rds_major_engine_version                    = "14.00"
    #rds_character_set_name                      = "AL32UTF8"
    rds_deletion_protection                     = false
    rds_final_snapshot_identifier               = "acexb"
    rds_secgrp_name                             = "sgr-ew1-ace-db-mssql-xb"
    rds_cidr_blocks                             = ["172.16.0.0/24"]
    rds_secret_name                             = "acpw-tcc-ace-db-mssql-xb"
    rds_optgrp_create                           = false
    rds_pargrp_create                           = false
}
