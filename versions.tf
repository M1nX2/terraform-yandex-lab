terraform {
  required_version = ">= 1.5.0"

  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.241.0"
    }
  }
}

# Аутентификация выполняется через YC_TOKEN, YC_CLOUD_ID и YC_FOLDER_ID
# либо через настроенный профиль Yandex Cloud CLI.
provider "yandex" {}
