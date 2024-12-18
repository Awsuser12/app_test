pipeline {
    agent any
    environment {
        AWS_REGION = 'eu-north-1' // AWS region
        ECR_REPO_URI = '329599658334.dkr.ecr.eu-north-1.amazonaws.com/my-app'
        IMAGE_TAG = 'latest'
        AWS_ACCESS_KEY_ID = credentials('AKIAUZPNLVFPGWGVS7G3') // Jenkins credentials ID
        AWS_SECRET_ACCESS_KEY = credentials('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') // Jenkins credentials ID
    }
    stages {
        stage('AWS ECR Login') {
            steps {
                script {
                    sh '''
                    aws configure set aws_access_key_id ${AWS_ACCESS_KEY_ID}
                    aws configure set aws_secret_access_key ${AWS_SECRET_ACCESS_KEY}
                    aws configure set default.region ${AWS_REGION}

                    aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${ECR_REPO_URI}
                    '''
                }
            }
        }

        stage('Build and Push Image') {
            steps {
                script {
                    sh '''
                    docker build -t my-app:${IMAGE_TAG} .
                    docker tag my-app:${IMAGE_TAG} ${ECR_REPO_URI}:${IMAGE_TAG}
                    docker push ${ECR_REPO_URI}:${IMAGE_TAG}
                    '''
                }
            }
        }
    }
}
