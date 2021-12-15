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
