# output "nodes" {
#   value = yandex_kubernetes_node_group.k8s_node_group
# }

output "cluster_nodes_group" {
  description = "returns a string"
  value       = yandex_kubernetes_node_group.node_groups.id
}

# output "nodes_ip" {
#   value = yandex_kubernetes_cluster.cluster.node_groups.0.internal_v4_endpoint
# }