#!/bin/bash

cd "$(dirname "$0")"

echo "🔍 Starting Infini-Quest Deployment Script"

# --- Check if docker is installed ---
if ! command -v docker &> /dev/null; then
    echo "❌ Docker is not installed. Please install Docker and try again."
    exit 1
fi

# --- Check if required ports are available ---
for port in 5000 9090; do
  if lsof -i:$port &> /dev/null; then
    echo "⚠️  Port $port is already in use. You may need to stop another process first."
  fi
done

# --- Build and start the stack ---
echo "🚀 Building and launching the application stack..."
docker-compose up -d --build

if [ $? -ne 0 ]; then
    echo "❌ Failed to build or start containers."
    exit 1
fi

# --- Wait for the app to become ready ---
echo "⏳ Waiting for the app to respond on /metrics..."
sleep 5

# --- Check /metrics endpoint ---
response=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:5000/metrics)

if [ "$response" == "200" ]; then
    echo "✅ Application metrics endpoint is live!"
else
    echo "❌ Application metrics endpoint is not responding (HTTP $response)"
    echo "   Please check logs with: docker-compose logs"
    exit 1
fi

# --- Final message ---
echo ""
echo "✅ Deployment complete!"
echo "📦 App:        http://localhost:5000/health"
echo "📊 Prometheus: http://localhost:9090"
echo "📈 Try query:  http_requests_total"

