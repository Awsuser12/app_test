pipeline {
    agent {
        docker {
            image 'python:3.11-slim'
            args '-u root'  // Allow Jenkins to run as root user
        }
    }
    stages {
        stage('Checkout') {
            steps {
                echo "Cloning the project..."
                git branch: 'main', url: 'https://github.com/Awsuser12/app_test.git'
            }
        }
        stage('Build') {
            steps {
                echo "Running Python inside Docker container"
                sh 'python --version'
            }
        }
    }
}
