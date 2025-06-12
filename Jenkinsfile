pipeline {
    agent any

    environment {
        // Docker Hub image details
        DOCKER_IMAGE = "echelonkay/flowbank-app"
        DOCKER_TAG = "v1.0.1"

        // Jenkins credentials ID for Docker Hub login
        REGISTRY_CREDENTIALS = "docker-hub-creds"
    }

    stages {

        stage('Checkout Code') {
            steps {
                git branch: 'test', url: 'https://github.com/SilasCloud/Flowbank.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    echo "Building Docker image: ${DOCKER_IMAGE}:${DOCKER_TAG}"
                    sh "docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} ."
                }
            }
        }

        stage('Login & Push to Docker Hub') {
            steps {
                script {
                    echo "Logging in to Docker Hub and pushing image..."
                    docker.withRegistry('', REGISTRY_CREDENTIALS) {
                        sh "docker push ${DOCKER_IMAGE}:${DOCKER_TAG}"
                    }
                }
            }
        }
    }

    post {
        success {
            echo "✅ Image pushed successfully: ${DOCKER_IMAGE}:${DOCKER_TAG}"
        }
        failure {
            echo "❌ Build failed. Please check logs for details."
        }
    }
}
