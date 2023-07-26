module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.1.1"

  name = "testtask-cluster"
  cidr = "10.5.0.0/16"

  azs             = ["us-east-1a", "us-east-1b"]
  private_subnets = ["10.5.1.0/24", "10.5.2.0/24"]
  public_subnets  = ["10.5.3.0/24", "10.5.4.0/24"]

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  public_subnet_tags = {
    "kubernetes.io/cluster/testtask-cluster" = "shared"
    "kubernetes.io/role/elb"                 = 1
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/testtask-cluster" = "shared"
    "kubernetes.io/role/internal-elb"        = 1
  }
}
