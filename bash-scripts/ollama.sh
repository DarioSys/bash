#!/bin/bash

# Verifica si hay instalacion antigua de docker y la remueve para instalar la mas reciente
for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do sudo apt-get remove $pkg; done

# Actualizando el sistema y añadiendo llaves
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Añadiendo repositorios
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

# Actualizando instalando docker.
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Instalando Ollama
docker run -d -v ollama:/root/.ollama -p 11434:11434 --name ollama ollama/ollama

# Instalando interfaz web
docker run -d --name webui -p 80:8080  -v open-webui:/app/backend/data -e WEBUI_AUTH=False -e OLLAMA_BASE_URL=http://localhost:11434  ghcr.io/open-webui/open-webui:main

# Habilitar puerto openwebui
iptables -A OUTPUT -p tcp --dport 8080 -j ACCEPT
iptables -A INPUT  -p tcp --sport 8080 -m state --state ESTABLISHED -j ACCEPT

# Guardar los cambios en iptables
iptables-save > /etc/iptables/rules.v4

# Corriendo el modelos
docker exec -it ollama ollama pull qwen3:0.6b ; ollama pull tinyllama:1.1b ; ollama pull gemma3:1b ; ollama pull smollm:1.7b ; ollama pull deepseek-r1:1.5b 


