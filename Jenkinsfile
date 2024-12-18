pipeline {
    agent any

    environment {
        AWS_DEFAULT_REGION = 'eu-north-1'  // Change to your AWS region
        ECR_REPO = 'project/healthsync-repository'
        EKS_CLUSTER_NAME = 'my-eks-cluster'
        KUBERNETES_NAMESPACE = 'default'  // Namespace where the app will be deployed
        DOCKER_IMAGE_TAG = 'latest'
    }

    stages {
        stage('Checkout') {
            steps {
                echo 'Cloning the repository...'
                git branch: 'main', url: 'https://github.com/Awsuser12/app_test.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo 'Building Docker image...'
                script {
                    docker.build("${ECR_REPO}:${DOCKER_IMAGE_TAG}")
                }
            }
        }

        stage('Push to ECR') {
            steps {
                echo 'Pushing Docker image to AWS ECR...'
                script {
                    // Get ECR login command
                    def ecrLogin = sh(script: 'aws ecr get-login-password --region ${AWS_DEFAULT_REGION} | docker login --username AWS --password-stdin <aws_account_id>.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com', returnStdout: true).trim()
                    sh "docker tag ${ECR_REPO}:${DOCKER_IMAGE_TAG} <aws_account_id>.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${ECR_REPO}:${DOCKER_IMAGE_TAG}"
                    sh "docker push <aws_account_id>.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${ECR_REPO}:${DOCKER_IMAGE_TAG}"
                }
            }
        }

        stage('Deploy to EKS') {
            steps {
                echo 'Deploying to EKS...'
                script {
                    // Update Kubernetes deployment to use the latest image
                    sh """
                    kubectl config use-context ${EKS_CLUSTER_NAME}
                    kubectl set image deployment/my-python-app my-python-app=<aws_account_id>.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${ECR_REPO}:${DOCKER_IMAGE_TAG} --record
                    kubectl apply -f k8s/service.yaml
                    kubectl apply -f k8s/deployment.yaml
                    """
                }
            }
        }

        stage('Verify Deployment') {
            steps {
                echo 'Verifying deployment...'
                script {
                    // Verify that the pod is running in EKS
                    sh "kubectl get pods -n ${KUBERNETES_NAMESPACE}"
                }
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
