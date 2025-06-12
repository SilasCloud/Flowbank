pipeline {
    agent any

    options {
        skipDefaultCheckout(true)
    }

    environment {
        DOCKER_IMAGE = "echelonkay/flowbank-app"
        DOCKER_TAG = "v1.0.1"
        REGISTRY_CREDENTIALS = "docker-hub-creds"
    }

    stages {
        stage('Build Docker Image') {
            steps {
                dir("${env.WORKSPACE}@script") {
                    script {
                        echo "Building Docker image: ${DOCKER_IMAGE}:${DOCKER_TAG}"
                        sh "docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} ."
                    }
                }
            }
        }

        stage('Login & Push to Docker Hub') {
            steps {
                dir("${env.WORKSPACE}@script") {
                    script {
                        echo "Logging in to Docker Hub and pushing image..."
                        docker.withRegistry('', REGISTRY_CREDENTIALS) {
                            sh "docker push ${DOCKER_IMAGE}:${DOCKER_TAG}"
                        }
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
