#!/bin/bash
set -euo pipefail

echo "🚀 Обновление системы и установка зависимостей..."
sudo apt-get update -qq
sudo apt-get install -yqq \
    curl \
    ca-certificates \
    gnupg \
    lsb-release \
    apt-transport-https \
    software-properties-common

echo "🔐 Добавление GPG-ключа Docker..."
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
    sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo "📦 Добавление Docker-репозитория..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "🔄 Обновление и установка Docker Engine (последняя версия)..."
sudo apt-get update -qq
sudo apt-get install -yqq docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "⚙️ Установка последней версии docker-compose (v2 CLI plugin)..."
LATEST_COMPOSE=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep browser_download_url | grep "$(uname -s)-$(uname -m)" | cut -d '"' -f 4)
sudo mkdir -p /usr/libexec/docker/cli-plugins
sudo curl -L "$LATEST_COMPOSE" -o /usr/libexec/docker/cli-plugins/docker-compose
sudo chmod +x /usr/libexec/docker/cli-plugins/docker-compose

echo "🧹 Удаление старого docker-compose (если есть)..."
sudo rm -f /usr/local/bin/docker-compose
sudo rm -f /usr/bin/docker-compose

echo "✅ Проверка версий:"
docker --version
docker compose version

echo "🚢 Запуск Portainer..."
sudo docker run -d \
  -p 8000:8000 \
  -p 9000:9000 \
  --name=portainer \
  --restart=always \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v /docker/portainer/host/data:/data \
  portainer/portainer-ce

echo "🎉 Установка завершена! Portainer доступен на http://localhost:9000"
