pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "echelonkay/flowbank-app"
        DOCKER_TAG = "v1.0.1"
        REGISTRY_CREDENTIALS = "docker-hub-creds"
    }

    stages {
        stage('Checkout Code') {
            steps {
                // Clean workspace and checkout
                deleteDir()
                checkout scm
                
                // Verify checkout worked
                sh 'ls -la'
                sh 'pwd'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    echo "Building Docker image: ${DOCKER_IMAGE}:${DOCKER_TAG}"
                    
                    // Verify Dockerfile exists
                    sh 'ls -la Dockerfile'
                    
                    // Build the image
                    def image = docker.build("${DOCKER_IMAGE}:${DOCKER_TAG}")
                }
            }
        }

        stage('Login & Push to Docker Hub') {
            steps {
                script {
                    echo "Logging in to Docker Hub and pushing image..."
                    docker.withRegistry('https://index.docker.io/v1/', REGISTRY_CREDENTIALS) {
                        def image = docker.image("${DOCKER_IMAGE}:${DOCKER_TAG}")
                        image.push()
                        image.push('latest')
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
        always {
            // Clean up docker images to save space
            sh 'docker system prune -f'
        }
    }
}