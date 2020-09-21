terraform {
  source = "git::https://git-codecommit.eu-central-1.amazonaws.com/v1/repos/terraform-aws-module-ocp3//ocp3?ref=v0.0.11"
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
  r53_ocp_private_zone_name             = "ocp3.dce.tcc.aws.internal"
  r53_ocp_private_zone_comment          = "DCE OCP3"
  r53_ocp_apps_private_zone_name        = "app.ocp3.dce.tcc.aws.internal"
  r53_ocp_apps_private_zone_comment     = "DCE OCP3 Applications"

  lb_name_master_api                    = "nlb-dce-ocp3-master-api"
  lb_name_router_int                    = "nlb-dce-ocp3-router-int"
  lb_name_router_ext                    = "nlb-dce-ocp3-router-ext"

  lb_target_group_name_master_api       = "lbtgr-dce-ocp3-master-api"
  lb_target_group_name_router_int_http  = "lbtgr-dce-ocp3-router-int-http"
  lb_target_group_name_router_int_https = "lbtgr-dce-ocp3-router-int-https"
  lb_target_group_name_router_ext_http  = "lbtgr-dce-ocp3-router-ext-http"
  lb_target_group_name_router_ext_https = "lbtgr-dce-ocp3-router-ext-https"

  efs_filesystem_name                   = "efs-ew1-dce-ocp3-pvols"
  efs_filesystem_region                 = "eu-west-1"

  s3_registry_storage_bucket_name       = "tcc-dce-ocp3-registry-storage"
  s3_registry_storage_bucket_region     = "eu-west-1"

  cluster_node_base_ami_id              = "ami-06439330b53709596"
  cluster_node_sysvol_snapshot_id       = ""
  admin_node_base_ami_id                = "ami-02ed0ffe3895fc7c0"
  admin_node_instance_type              = "t2.medium"
  master_node_instance_type             = "t3a.xlarge"
  compute_node_instance_type            = "r5n.2xlarge"
  router_node_instance_type             = "t2.large"
  infra_node_instance_type              = "r5n.xlarge"
  ssh_keypair_name                      = "sshkey-tcc-dce-ocp3"
  ssh_username                          = "ec2-user"

  aws_secret_name_sshkey                = "sshkey-tcc-dce-ocp3"
  aws_secret_name_rhsm                  = "acpw-tcc-dce-ocp3-rhsm-fx"
  aws_secret_name_ldap_cred             = "acpw-tcc-dce-ocp3-ldap-fx"
  aws_secret_name_ldap_cert             = "cert-tcc-ew1-ad-ldaps-certbody"
  aws_secret_name_cert_body             = "cert-tcc-dce-ocp3-fx-certbody"
  aws_secret_name_cert_ca_body          = "cert-tcc-dce-ocp3-fx-ca"
  aws_secret_name_cert_private_key      = "cert-tcc-dce-ocp3-fx-certprivatkey"

  iam_instance_role_name                = "ocp3-dce-instance-role"
  iam_instance_policy_s3_name           = "ocp3-dce-instance-policy-s3"
  iam_instance_policy_ec2_name          = "ocp3-dce-instance-policy-ec2"

  ocp3_auto_install                     = false

  ocp3_master_instances                 = ["ec2-ew1-1a-dce-ocp3-master01", "ec2-ew1-1b-dce-ocp3-master02", "ec2-ew1-1c-dce-ocp3-master03"]

  ocp3_router_int_instances             = ["ec2-ew1-1a-dce-ocp3-router01", "ec2-ew1-1b-dce-ocp3-router02", "ec2-ew1-1c-dce-ocp3-router03"]

  ocp3_router_ext_instances             = ["ec2-ew1-1a-dce-ocp3-router04", "ec2-ew1-1b-dce-ocp3-router05", "ec2-ew1-1c-dce-ocp3-router06"]

  ocp3_compute_instances                = ["ec2-ew1-1a-dce-ocp3-compute01", "ec2-ew1-1b-dce-ocp3-compute02", "ec2-ew1-1c-dce-ocp3-compute03",
                                           "ec2-ew1-1a-dce-ocp3-compute04", "ec2-ew1-1b-dce-ocp3-compute05", "ec2-ew1-1c-dce-ocp3-compute06",
                                           "ec2-ew1-1a-dce-ocp3-compute07", "ec2-ew1-1b-dce-ocp3-compute08"]

  ocp3_infra_instances                  = ["ec2-ew1-1a-dce-ocp3-infra01", "ec2-ew1-1b-dce-ocp3-infra02", "ec2-ew1-1c-dce-ocp3-infra03"]

  ocp3_admin_instances                  = ["ec2-ew1-1a-dce-ocp3-admin"]

  ocp3_admin_secgrp_name                = "sgr-ew1-dce-openshift-admin"
  ocp3_master_secgrp_name               = "sgr-ew1-dce-openshift-master"
  ocp3_node_secgrp_name                 = "sgr-ew1-dce-openshift-node"
  ocp3_infra_secgrp_name                = "sgr-ew1-dce-openshift-infra"
  ocp3_router_int_secgrp_name           = "sgr-ew1-dce-openshift-router-int"
  ocp3_router_ext_secgrp_name           = "sgr-ew1-dce-openshift-router-ext"
  ocp3_efs_secgrp_name                  = "sgr-ew1-dce-ocp3-efs"

  ocp3_cluster_id                       = "dce-ocp3"

  tags = {
    "kubernetes.io/cluster/dce-ocp3"    = "owned",
    "Environment"                       = "DCE",
    "Customer"                          = "TCC",
    "Owner"                             = "Infrastructure Services",
    "Project"                           = "EPIC AWS Cloud Infrastructure Readiness",
    "Managed by"                        = "Terraform",
  }
}
