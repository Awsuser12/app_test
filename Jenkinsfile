pipeline {
    agent {
        docker {
            image 'python:3.11-slim'  // Use Python 3.11 Docker image
            args '-u root'  // Allow Jenkins to run as root user
        }
    }

    environment {
        APP_DIR = "/app"  // Application directory
    }

    stages {
        stage('Checkout') {
            steps {
                echo "Cloning the project from GitHub..."
                git branch: 'main', url: 'https://github.com/Awsuser12/app_test.git'
            }
        }

        stage('Install Dependencies') {
            steps {
                echo "Installing dependencies..."
                sh 'pip install --no-cache-dir -r requirements.txt'
            }
        }

        stage('Build') {
            steps {
                echo "Running Python inside Docker container"
                sh 'python --version'
            }
        }

        stage('Run Application') {
            steps {
                echo "Running the Python application..."
                sh 'python app.py &'
            }
        }

        stage('Verify Application') {
            steps {
                echo "Verifying the application..."
                sh 'curl http://localhost:5000'
            }
        }
    }

    post {
        success {
            echo "Pipeline executed successfully!"
        }
        failure {
            echo "Pipeline failed. Please check the logs."
        }
    }
}
