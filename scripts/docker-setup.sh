#!/bin/env bash

echo "setting up docker"

sudo apt-get install \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg \
        lsb-release

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io

sudo usermod -aG docker $USER

docker network create --gateway 172.18.0.1 --subnet 172.18.0.0/24 pagevamp


## Setup docker compose

temp=$( realpath "$0"  )
CURRENT_DIR=$(dirname "$temp")

if [ -d $HOME/.rbenv ]; then
  export PATH="$HOME/.rbenv/shims:$PATH"
  eval "$(rbenv init -)"
fi

file_path="${CURRENT_DIR}/../ruby/parse_webpage.rb"

COMPOSE_VERSION=$(ruby "$file_path" "https://github.com/docker/compose/tree/v2")

mkdir -p ~/.docker/cli-plugins/

curl -SL "https://github.com/docker/compose/releases/download/v${COMPOSE_VERSION}/docker-compose-linux-x86_64" -o ~/.docker/cli-plugins/docker-compose

chmod +x ~/.docker/cli-plugins/docker-compose

echo "$(docker compose version)"
