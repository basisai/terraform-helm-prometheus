resource "helm_release" "node_exporter" {
  count = var.node_exporter_enable ? 1 : 0

  name       = var.node_exporter_release_name
  chart      = var.node_exporter_chart_name
  repository = var.node_exporter_chart_repository
  version    = var.node_exporter_chart_version
  namespace  = var.node_exporter_chart_namespace

  max_history = var.max_history

  values = [
    templatefile("${path.module}/templates/node_exporter.yaml", local.node_exporter_values),
  ]
}


locals {
  node_exporter_values = {
    enable = var.node_exporter_enable

    host_network = var.node_exporter_host_network
    host_pid     = var.node_exporter_host_pid

    repository  = var.node_exporter_repository
    tag         = var.node_exporter_tag
    pull_policy = var.node_exporter_pull_policy

    pod_security_policy_annotations = jsonencode(var.node_exporter_pod_security_policy_annotations)

    replica   = var.node_exporter_replica
    resources = jsonencode(var.node_exporter_resources)

    annotations   = jsonencode(var.node_exporter_annotations)
    tolerations   = jsonencode(var.node_exporter_tolerations)
    labels        = jsonencode(var.node_exporter_labels)
    node_selector = jsonencode(var.node_exporter_node_selector)

    security_context = coalesce(
      var.node_exporter_security_context_json,
      jsonencode(var.node_exporter_security_context),
    )

    host_path_mounts  = jsonencode(var.node_exporter_host_path_mounts)
    config_map_mounts = jsonencode(var.node_exporter_config_map_mounts)

    priority_class_name = var.node_exporter_priority_class_name
    extra_args          = jsonencode(var.node_exporter_extra_args)

    service_annotations      = jsonencode(var.node_exporter_service_annotations)
    service_labels           = jsonencode(var.node_exporter_service_labels)
    service_cluster_ip       = jsonencode(var.node_exporter_service_cluster_ip)
    service_external_ips     = jsonencode(var.node_exporter_service_external_ips)
    service_lb_ip            = jsonencode(var.node_exporter_service_lb_ip)
    service_lb_source_ranges = jsonencode(var.node_exporter_service_lb_source_ranges)
    service_port             = var.node_exporter_service_port
    service_type             = var.node_exporter_service_type

    pod_security_policy_annotations = jsonencode(var.node_exporter_pod_security_policy_annotations)

    pdb_enable          = var.node_exporter_pdb_enable
    pdb_max_unavailable = jsonencode(var.node_exporter_pdb_max_unavailable)
  }
}
