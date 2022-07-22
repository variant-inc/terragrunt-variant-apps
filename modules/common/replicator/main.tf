data "kubernetes_namespace" "namespace" {
  metadata {
    name = var.namespace
  }
}

resource "kubernetes_config_map" "iaac_replicator" {
  metadata {
    name      = "${var.release_data.project}-iaac-replicator"
    namespace = data.kubernetes_namespace.namespace.metadata[0].name
    labels = {
      "cloudops.iaac/replicator" : "v1"
    }
  }

  data = {
    "Space" : "${var.release_data.space}"
    "Project" : "${var.release_data.project}"
    "GithubRepository" : "${var.release_data.repository}"
    "GithubUser" : "${var.release_data.user}"
    "Version" : "${var.release_data.version}"
    "Image" : "${var.release_data.image}"
    "IsInfrastructure" : "${var.release_data.is_infrastructure}"
    "ActionsOctopusVersion" : "${var.actions_octopus_version}"
  }
}
