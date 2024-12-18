pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'python:3.11-slim'
        CONTAINER_NAME = 'python-app-container'
    }

    stages {
        stage('Pull Docker Image') {
            steps {
                script {
                    // Pull the latest image
                    sh "docker pull ${DOCKER_IMAGE}"
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    // Run the Docker container with --network host to ensure proper networking
                    sh "docker run -d --name ${CONTAINER_NAME} --network host ${DOCKER_IMAGE}"
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
    }
}
