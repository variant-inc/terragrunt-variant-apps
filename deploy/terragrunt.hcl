remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket  = "engineering-tf-state20210118220815943200000002"
    region  = "us-east-1"
    key     = "space/project-group/project-name/${path_relative_to_include()}/terraform.tfstate"
    encrypt = true
  }
}

inputs = {
  name         = "jazz-backend-api"
  namespace    = "tesh"
  cluster_name = "variant-dev"
  chart_value_overrides = [yamlencode({
    revision = "0.0.1"
    istio = {
      ingress = {
        host = "dev-drivevariant.com"
      }
    }
    deployment = {
      image = {
        tag = "064859874041.dkr.ecr.us-east-2.amazonaws.com/jazz-backend/api:0.1.0-cloud-1105-0001.121"
      }
    }
    service = {
      targetPort = 5001
    }
  })]

  bucket_config = {
    env = "non-prod"
    managed = [
      {
        id   = "jazz-test"
        name = "jazz-test"
      }
    ]
    existing = [
      {
        id   = "optimizer"
        name = "usxopt-ds-dev"
      }
    ]
  }

  user_tags = {
    team    = "datascience"
    owner   = "datascience"
    purpose = "Jazz Backend API"
  }
  octopus_tags = {
    release_channel = "feature"
    environment     = "development"
    project_group   = "Default"
    space           = "Engineering"
    project         = "jazz-backend-api"
  }
}
