#!/bin/bash
set -e

BRANCH=$1   # pass dev or main as argument
DOCKER_USER="dharineesh01"
CONTAINER_NAME="react-container"

if [ -z "$BRANCH" ]; then
  echo "⚠️ Usage: ./deploy.sh <branch>"
  exit 1
fi

# Remove old container if exists
echo "🔹 Cleaning old container..."
docker rm -f $CONTAINER_NAME 2>/dev/null || true

# Run container based on branch
if [ "$BRANCH" == "dev" ]; then
  echo "🔹 Deploying Dev image..."
  docker run -d -p 80:80 --name $CONTAINER_NAME $DOCKER_USER/dev:latest
  echo "✅ Running Dev: http://$(curl -s ifconfig.me)"

elif [ "$BRANCH" == "main" ]; then
  echo "🔹 Deploying Prod image..."
  docker run -d -p 80:80 --name $CONTAINER_NAME $DOCKER_USER/prod:latest
  echo "✅ Running Prod: http://$(curl -s ifconfig.me)"

else
  echo "❌ Unknown branch: $BRANCH"
  exit 1
fi


