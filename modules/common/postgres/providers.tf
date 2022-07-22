provider "aws" {
  default_tags {
    tags = var.tags
  }
}

data "aws_eks_cluster" "cluster" {
  name = var.cluster_name
}

data "aws_eks_cluster_auth" "cluster" {
  name = var.cluster_name
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}

provider "postgresql" {
  host            = local.creds["host"]
  username        = local.creds["username"]
  password        = local.creds["password"]
  connect_timeout = 30
  superuser       = false
}
