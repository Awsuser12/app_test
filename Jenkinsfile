pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID = 'AKIAVFIWI7H2KV4XOTUE'
        AWS_SECRET_ACCESS_KEY = '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'
        AWS_DEFAULT_REGION = 'us-east-1'
    }

    stages {
        stage('Build Docker Image') {
            steps {
                echo "Building Docker image..."
                sh 'docker build -t 354918398452.dkr.ecr.us-east-1.amazonaws.com/healthsync:latest .'
            }
        }

        stage('Push to ECR') {
            steps {
                echo "Pushing Docker image to AWS ECR..."
                sh '''
                aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 354918398452.dkr.ecr.us-east-1.amazonaws.com
                docker push 354918398452.dkr.ecr.us-east-1.amazonaws.com/healthsync:latest
                '''
            }
        }

        stage('Deploy to EKS') {
            steps {
                echo "Deploying to EKS..."
                sh '''
                aws eks --region us-east-1 update-kubeconfig --name MyCluster
                cp /var/jenkins_home/deployment.yaml ${WORKSPACE}/deployment.yaml
                kubectl apply -f ${WORKSPACE}/deployment.yaml
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
