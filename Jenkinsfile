pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'python:3.11-slim'
        CONTAINER_NAME = 'python-app-container'
        AWS_REGION = 'eu-north-1' // Replace with your AWS region
        ECR_REPO_URI = '329599658334.dkr.ecr.eu-north-1.amazonaws.com/my-app' // Replace with your ECR repo URI
        IMAGE_TAG = 'latest' // Tag for the Docker image
    }

    stages {
        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Pull Docker Image') {
            steps {
                script {
                    // Pull the latest image
                    sh "docker pull ${DOCKER_IMAGE}"
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image with the app
                    sh "docker build -t my-app:${IMAGE_TAG} ."
                }
            }
        }

        stage('Tag Docker Image') {
            steps {
                script {
                    // Tag the image with the ECR URI
                    sh "docker tag my-app:${IMAGE_TAG} ${ECR_REPO_URI}:${IMAGE_TAG}"
                }
            }
        }

        stage('Push to ECR') {
            steps {
                script {
                    // Login to AWS ECR and push the image
                    sh '''
                    aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${ECR_REPO_URI}
                    docker push ${ECR_REPO_URI}:${IMAGE_TAG}
                    '''
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    // Run the Docker container with --network host to ensure proper networking
                    sh "docker run -d --name ${CONTAINER_NAME} --network host my-app:${IMAGE_TAG}"
                }
            }
        }

        stage('Verify Application') {
            steps {
                script {
                    // Verify that the application is running
                    sh "curl -s http://localhost:5000 || exit 1"
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    // Deploy the image to Kubernetes
                    sh '''
                    kubectl set image deployment/my-app my-app=${ECR_REPO_URI}:${IMAGE_TAG} --record
                    kubectl rollout status deployment/my-app
                    '''
                }
            }
        }

        stage('Stop Docker Container') {
            steps {
                script {
                    // Clean up by stopping the container
                    sh "docker stop ${CONTAINER_NAME}"
                    sh "docker rm ${CONTAINER_NAME}"
                }
            }
        }
    }

    post {
        always {
            // Ensure Docker container is stopped and removed in case of failure
            script {
                sh "docker stop ${CONTAINER_NAME} || true"
                sh "docker rm ${CONTAINER_NAME} || true"
            }
        }

        success {
            echo 'Pipeline completed successfully!'
        }

        failure {
            echo 'Pipeline failed.'
        }
    }
}
