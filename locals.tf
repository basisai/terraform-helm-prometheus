locals {
  prometheus_server_url       = "http://${helm_release.prometheus.metadata[0].name}-server.${helm_release.prometheus.metadata[0].namespace}.svc.cluster.local:${var.server_service_port}"
  prometheus_alertmanager_url = "http://${helm_release.prometheus.metadata[0].name}-alertmanager.${helm_release.prometheus.metadata[0].namespace}.svc.cluster.local:${var.alertmanager_service_port}"

  prometheus_query_api_url = coalesce(var.prometheus_remote_read_api_url, local.prometheus_server_url)
  prometheus_alerts_api_url = local.prometheus_server_url

  self_scrape_config = [
    {
      job_name = "prometheus"
      static_configs = [
        {
          targets = ["localhost:9090"]
        }
      ]
    }
  ]

  scrape_config_values = {
    scrape_skip_apiserver_tls_verify = var.scrape_skip_apiserver_tls_verify
    scrape_skip_nodes_tls_verify     = var.scrape_skip_nodes_tls_verify
  }
}
