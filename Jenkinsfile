pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-creds')
        IMAGE_NAME = 'echelonkay/flowbank-app'
        DOCKER_TAG = 'latest'
    }

    stages {
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE_NAME:$DOCKER_TAG .'
            }
        }

        stage('Docker Hub Login') {
            steps {
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
            }
        }

        stage('Push Image') {
            steps {
                sh 'docker push $IMAGE_NAME:$DOCKER_TAG'
            }
        }
    }

    post {
        success {
            echo "✅ Image pushed successfully: ${env.IMAGE_NAME}:${env.DOCKER_TAG}"
        }
        failure {
            echo "❌ Build failed. Please check logs for details."
        }
    }
}
