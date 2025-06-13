#!/bin/bash

echo "=========================="
echo "✅ Checking for Homebrew..."
echo "=========================="
if ! command -v brew &> /dev/null; then
    echo "❌ Homebrew not found. Installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "✅ Homebrew is already installed."
fi

echo "=========================="
echo "📦 Installing Minikube via Homebrew..."
echo "=========================="
brew install minikube

echo "=========================="
echo "📦 Installing kubectl via Homebrew..."
echo "=========================="
brew install kubectl

echo "=========================="
echo "🚀 Starting Minikube (Docker driver, 2 CPUs, 3.5GB RAM)..."
echo "=========================="
minikube start --driver=docker --container-runtime=containerd --cpus=2 --memory=3500

echo "=========================="
echo "🔄 Setting kubectl context to Minikube..."
echo "=========================="
kubectl config use-context minikube

echo "=========================="
echo "🔍 Checking Minikube status..."
echo "=========================="
minikube status

echo "=========================="
echo "🔍 Verifying Kubernetes nodes..."
echo "=========================="
kubectl get nodes

