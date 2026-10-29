variable "network_name" {
  description = "Имя облачной сети"
  type        = string
  default     = "tf-lesson-vpc"
}

variable "subnet_name" {
  description = "Имя подсети"
  type        = string
  default     = "tf-lesson-subnet"
}

variable "subnet_cidr" {
  description = "CIDR подсети"
  type        = string
  default     = "10.10.0.0/24"
}

variable "zone" {
  description = "Зона доступности"
  type        = string
  default     = "ru-central1-a"
}

variable "platform_id" {
  description = "Тип вычислительной платформы"
  type        = string
  default     = "standard-v3"
}

variable "cores" {
  description = "Количество vCPU"
  type        = number
  default     = 2
}

variable "core_fraction" {
  description = "Доля производительности vCPU в процентах"
  type        = number
  default     = 100
}

variable "memory" {
  description = "Объём оперативной памяти в ГБ"
  type        = number
  default     = 2
}

variable "disk_size" {
  description = "Размер загрузочного диска в ГБ"
  type        = number
  default     = 10
}

variable "web_instance_name" {
  description = "Имя виртуальной машины web"
  type        = string
  default     = "web"
}

variable "worker_instance_name" {
  description = "Имя виртуальной машины worker"
  type        = string
  default     = "worker"
}

variable "web_security_group_name" {
  description = "Имя группы безопасности web"
  type        = string
  default     = "web-sg"
}

variable "worker_security_group_name" {
  description = "Имя группы безопасности worker"
  type        = string
  default     = "worker-sg"
}

variable "ssh_public_key" {
  description = "Публичный SSH-ключ пользователя ubuntu (не секрет)"
  type        = string
  default     = ""
}
