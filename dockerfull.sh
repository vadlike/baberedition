#!/bin/bash
set -euo pipefail

# Обновление и установленные зависимости
sudo apt-get update -qq
sudo apt-get install -yqq \
    curl \
    git \
    apt-transport-https \
    ca-certificates \
    gnupg \
    lsb-release

# Добавление репозитория Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Установка Docker
sudo apt-get update -qq
sudo apt-get install -yqq docker-ce docker-ce-cli containerd.io

# Установка docker-compose v2 как плагина
DOCKER_COMPOSE_VERSION="v2.22.0"  # можно обновить при необходимости
sudo curl -SL "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" \
    -o /usr/libexec/docker/cli-plugins/docker-compose
sudo chmod +x /usr/libexec/docker/cli-plugins/docker-compose

# Проверка доступности плагина
if ! docker compose version &>/dev/null; then
  echo "⚠️ docker-compose plugin не обнаружен!"
  exit 1
fi

# Удаление старой команды (если была)
if [[ -L /usr/bin/docker-compose ]]; then
  sudo rm /usr/bin/docker-compose
fi

# Запуск Portainer
sudo docker run -d \
  -p 8000:8000 \
  -p 9000:9000 \
  --name=portainer \
  --restart=always \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v /docker/portainer/host/data:/data \
  portainer/portainer-ce

# Вывод версий
echo "✅ Docker version:"
docker --version
echo "✅ Docker Compose version:"
docker compose version
