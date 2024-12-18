pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID = 'AKIAUZPNLVFPGWGVS7G3'
        AWS_SECRET_ACCESS_KEY = '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'
        AWS_DEFAULT_REGION = 'eu-north-1'
    }

    stages {
        stage('Build Docker Image') {
            steps {
                echo "Building Docker image..."
                sh 'docker build -t 329599658334.dkr.ecr.eu-north-1.amazonaws.com/healthsync-repository:latest .'
            }
        }

        stage('Push to ECR') {
            steps {
                echo "Pushing Docker image to AWS ECR..."
                sh '''
                aws ecr get-login-password --region eu-north-1 | docker login --username AWS --password-stdin 329599658334.dkr.ecr.eu-north-1.amazonaws.com
                docker push 329599658334.dkr.ecr.eu-north-1.amazonaws.com/my-app:latest
                '''
            }
        }

        stage('Deploy to EKS') {
            steps {
                echo "Deploying to EKS..."
                sh '''
                kubectl apply -f deployment.yaml
                '''
            }
        }

        stage('Verify Deployment') {
            steps {
                echo "Verifying deployment..."
                sh 'kubectl get pods'
            }
        }
    }
}
