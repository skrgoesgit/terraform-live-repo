terraform {
  #source = "git::https://git-codecommit.eu-central-1.amazonaws.com/v1/repos/terraform-aws-module-ocp3//ocp3?ref=v0.0.11"
  source = "git::https://github.com/skruegergoesgit/terraform-aws-module-ocp3//ocp3?ref=v0.0.11"
}

include {
  path = find_in_parent_folders()
}

dependency "vpc" {
  config_path = "../../vpc"
}

inputs = {
  vpc_id                                = dependency.vpc.outputs.vpc_id
  ocp3_subnet_ids                       = dependency.vpc.outputs.ocp3_subnet_ids
  internal_subnet_ids                   = dependency.vpc.outputs.internal_subnet_ids

  r53_ocp_private_zone_name             = "ocp3.ace.tcc.aws.internal"
  r53_ocp_private_zone_comment          = "ACE OCP3 / changed by SKR via TF"
  r53_ocp_apps_private_zone_name        = "app.ocp3.ace.tcc.aws.internal"
  r53_ocp_apps_private_zone_comment     = "ACE OCP3 Applications"

  lb_name_master_api                    = "nlb-ace-ocp3-master-api"
  lb_name_router_int                    = "nlb-ace-ocp3-router-int"
  lb_name_router_ext                    = "nlb-ace-ocp3-router-ext"

  lb_target_group_name_master_api       = "lbtgr-ace-ocp3-master-api"
  lb_target_group_name_router_int_http  = "lbtgr-ace-ocp3-router-int-http"
  lb_target_group_name_router_int_https = "lbtgr-ace-ocp3-router-int-https"
  lb_target_group_name_router_ext_http  = "lbtgr-ace-ocp3-router-ext-http"
  lb_target_group_name_router_ext_https = "lbtgr-ace-ocp3-router-ext-https"

  efs_filesystem_name                   = "efs-ew1-ace-ocp3-pvols"
  efs_filesystem_region                 = "eu-west-1"

  s3_registry_storage_bucket_name       = "tcc-ace-ocp3-registry-storage"
  s3_registry_storage_bucket_region     = "eu-west-1"

  cluster_node_base_ami_id              = "ami-08be75d65c3768e22"
  cluster_node_sysvol_snapshot_id       = ""
  admin_node_base_ami_id                = "ami-02ed0ffe3895fc7c0"
  admin_node_instance_type              = "t2.medium"
  master_node_instance_type             = "t3a.xlarge"
  compute_node_instance_type            = "r5n.large"
  router_node_instance_type             = "t2.large"
  infra_node_instance_type              = "r5n.large"
  ssh_keypair_name                      = "sshkey-tcc-ace-ocp3"
  ssh_username                          = "ec2-user"

  aws_secret_name_sshkey                = "sshkey-tcc-ace-ocp3"
  aws_secret_name_rhsm                  = "acpw-tcc-ace-ocp3-rhsm-fx"
  aws_secret_name_ldap_cred             = "acpw-tcc-ace-ocp3-ldap-fx"
  aws_secret_name_ldap_cert             = "cert-tcc-ew1-ad-ldaps-certbody"
  aws_secret_name_cert_body             = "cert-tcc-ace-ocp3-fx-certbody"
  aws_secret_name_cert_ca_body          = "cert-tcc-ace-ocp3-fx-ca"
  aws_secret_name_cert_private_key      = "cert-tcc-ace-ocp3-fx-certprivatkey"

  iam_instance_role_name                = "ocp3-ace-instance-role"
  iam_instance_policy_s3_name           = "ocp3-ace-instance-policy-s3"
  iam_instance_policy_ec2_name          = "ocp3-ace-instance-policy-ec2"

  ocp3_auto_install                     = false

  ocp3_master_instances                 = ["ec2-ew1-1a-ace-ocp3-master01", "ec2-ew1-1b-ace-ocp3-master02", "ec2-ew1-1c-ace-ocp3-master03"]

  ocp3_router_int_instances             = ["ec2-ew1-1a-ace-ocp3-router01"]

  ocp3_router_ext_instances             = ["ec2-ew1-1a-ace-ocp3-router04"]

  ocp3_compute_instances                = ["ec2-ew1-1a-ace-ocp3-compute01", "ec2-ew1-1b-ace-ocp3-compute02"]

  ocp3_infra_instances                  = ["ec2-ew1-1a-ace-ocp3-infra01"]

  ocp3_admin_instances                  = ["ec2-ew1-1a-ace-ocp3-admin"]

  ocp3_admin_secgrp_name                = "sgr-ew1-ace-openshift-admin"
  ocp3_master_secgrp_name               = "sgr-ew1-ace-openshift-master"
  ocp3_node_secgrp_name                 = "sgr-ew1-ace-openshift-node"
  ocp3_infra_secgrp_name                = "sgr-ew1-ace-openshift-infra"
  ocp3_router_int_secgrp_name           = "sgr-ew1-ace-openshift-router-int"
  ocp3_router_ext_secgrp_name           = "sgr-ew1-ace-openshift-router-ext"
  ocp3_efs_secgrp_name                  = "sgr-ew1-ace-ocp3-efs"

  ocp3_cluster_id                       = "ace-ocp3"

  tags = {
    "kubernetes.io/cluster/ace-ocp3"    = "owned",
    "Environment"                       = "ACE",
    "Customer"                          = "TCC",
    "Owner"                             = "Infrastructure Services",
    "Project"                           = "EPIC AWS Cloud Infrastructure Readiness",
    "Managed by"                        = "Terraform",
  }
}
