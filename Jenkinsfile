pipeline {
    agent any
    environment {
        AWS_REGION = 'eu-north-1' // AWS region
        ECR_REPO_URI = '329599658334.dkr.ecr.eu-north-1.amazonaws.com/my-app'
        IMAGE_TAG = 'latest'
        AWS_ACCESS_KEY_ID = credentials('aws-access-key-id') // Jenkins credentials ID
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key') // Jenkins credentials ID
    }
    stages {
        stage('AWS ECR Login') {
            steps {
                script {
                    sh '''
                    export AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}
                    export AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}
                    export AWS_DEFAULT_REGION=${AWS_REGION}

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
