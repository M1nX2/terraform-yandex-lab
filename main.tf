data "yandex_compute_image" "ubuntu" {
  family = "ubuntu-2204-lts"
}

resource "yandex_vpc_network" "main" {
  name = var.network_name
}

resource "yandex_vpc_subnet" "main" {
  name           = var.subnet_name
  zone           = var.zone
  network_id     = yandex_vpc_network.main.id
  v4_cidr_blocks = [var.subnet_cidr]
}

resource "yandex_vpc_security_group" "web" {
  name       = var.web_security_group_name
  network_id = yandex_vpc_network.main.id

  ingress {
    description    = "SSH"
    protocol       = "TCP"
    port           = 22
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description    = "HTTP API"
    protocol       = "TCP"
    port           = 8080
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description    = "Исходящий трафик"
    protocol       = "ANY"
    from_port      = 0
    to_port        = 65535
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_vpc_security_group" "worker" {
  name       = var.worker_security_group_name
  network_id = yandex_vpc_network.main.id

  ingress {
    description    = "SSH только из внутренней подсети"
    protocol       = "TCP"
    port           = 22
    v4_cidr_blocks = [var.subnet_cidr]
  }

  egress {
    description    = "Исходящий трафик"
    protocol       = "ANY"
    from_port      = 0
    to_port        = 65535
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_compute_instance" "web" {
  name                      = var.web_instance_name
  platform_id               = var.platform_id
  zone                      = var.zone
  allow_stopping_for_update = true

  resources {
    cores         = var.cores
    core_fraction = var.core_fraction
    memory        = var.memory
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
      size     = var.disk_size
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.main.id
    nat                = true
    security_group_ids = [yandex_vpc_security_group.web.id]
  }

  metadata = merge(
    {
      user-data = file("${path.module}/cloud-init-web.yaml")
    },
    var.ssh_public_key != "" ? { ssh-keys = "ubuntu:${var.ssh_public_key}" } : {}
  )
}

resource "yandex_compute_instance" "worker" {
  name                      = var.worker_instance_name
  platform_id               = var.platform_id
  zone                      = var.zone
  allow_stopping_for_update = true

  resources {
    cores         = var.cores
    core_fraction = var.core_fraction
    memory        = var.memory
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
      size     = var.disk_size
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.main.id
    nat                = false
    security_group_ids = [yandex_vpc_security_group.worker.id]
  }

  metadata = merge(
    {
      user-data = file("${path.module}/cloud-init-worker.yaml")
    },
    var.ssh_public_key != "" ? { ssh-keys = "ubuntu:${var.ssh_public_key}" } : {}
  )
}
