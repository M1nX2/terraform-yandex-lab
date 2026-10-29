output "web_public_ip" {
  description = "Публичный IPv4-адрес ВМ web"
  value       = yandex_compute_instance.web.network_interface[0].nat_ip_address
}

output "web_private_ip" {
  description = "Внутренний IPv4-адрес ВМ web"
  value       = yandex_compute_instance.web.network_interface[0].ip_address
}

output "worker_private_ip" {
  description = "Внутренний IPv4-адрес ВМ worker"
  value       = yandex_compute_instance.worker.network_interface[0].ip_address
}

output "network_id" {
  description = "Идентификатор VPC"
  value       = yandex_vpc_network.main.id
}

output "subnet_id" {
  description = "Идентификатор подсети"
  value       = yandex_vpc_subnet.main.id
}

output "web_instance_id" {
  description = "Идентификатор ВМ web"
  value       = yandex_compute_instance.web.id
}

output "worker_instance_id" {
  description = "Идентификатор ВМ worker"
  value       = yandex_compute_instance.worker.id
}
