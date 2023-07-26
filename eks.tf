provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    args        = ["eks", "get-token", "--cluster-name", "testtask-cluster"]
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.15.3"

  cluster_name                    = "testtask-cluster"
  cluster_version                 = "1.27"
  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true

  cluster_addons = {
    coredns = {
      resolve_conflicts = "OVERWRITE"
    }
  }

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  manage_aws_auth_configmap = true

  cluster_security_group_additional_rules = {
    egress_nodes_ephemeral_ports_tcp = {
      protocol                   = "tcp"
      from_port                  = 1025
      to_port                    = 65535
      type                       = "egress"
      source_node_security_group = true
    }
  }

  node_security_group_additional_rules = {
    ingress_self_all = {
      protocol  = "-1"
      from_port = 0
      to_port   = 0
      type      = "ingress"
      self      = true
    }

    egress_all = {
      protocol    = "-1"
      from_port   = 0
      to_port     = 0
      type        = "egress"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  eks_managed_node_group_defaults = {
    ami_type       = "AL2_x86_64"
    disk_size      = 50
    instance_types = ["t3.small"]
  }

  eks_managed_node_groups = {
    default_node_group = {
      min_size       = 4
      max_size       = 4
      desired_size   = 4
      instance_types = ["t3.small"]
    }
  }
}
