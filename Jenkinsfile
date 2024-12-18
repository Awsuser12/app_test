pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID = credentials('aws-access-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key')
    }
    stages {
        stage('Test Credentials') {
            steps {
                script {
                    sh '''
                    echo "AWS Access Key: ${AWS_ACCESS_KEY_ID}"
                    echo "AWS Secret Access Key: ${AWS_SECRET_ACCESS_KEY}"
                    '''
                }
            }
        }
    }
}
