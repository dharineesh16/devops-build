#!/bin/bash
set -e

BRANCH=$1   # pass dev or main as argument
DOCKER_USER="dharineesh01"
IMAGE_NAME="react-app"

if [ -z "$BRANCH" ]; then
  echo "⚠️ Usage: ./build.sh <branch>"
  exit 1
fi

# Build image
echo "🔹 Building Docker image..."
docker build -t $IMAGE_NAME .

# Push based on branch
if [ "$BRANCH" == "dev" ]; then
  docker tag $IMAGE_NAME $DOCKER_USER/dev:latest
  docker push $DOCKER_USER/dev:latest
  echo "✅ Dev image pushed: $DOCKER_USER/dev:latest"

elif [ "$BRANCH" == "main" ]; then
  docker tag $IMAGE_NAME $DOCKER_USER/prod:latest
  docker push $DOCKER_USER/prod:latest
  echo "✅ Prod image pushed: $DOCKER_USER/prod:latest"

else
  echo "❌ Unknown branch: $BRANCH"
  exit 1
fi


