
pipeline {
    agent any

    environment {
        AWS_ACCOUNT_ID = '<AWS_ACCOUNT_ID>'
        AWS_REGION = '<AWS_REGION>'
        ECR_REPO = 'hello-world-microservice'
        IMAGE_REPO_NAME = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPO}"
        IMAGE_TAG = "latest"
        CLUSTER_NAME = '<ECS_CLUSTER_NAME>'
        SERVICE_NAME = '<ECS_SERVICE_NAME>'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: '<YOUR_REPOSITORY_URL>'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("${IMAGE_REPO_NAME}:${IMAGE_TAG}")
                }
            }
        }

        stage('Push to ECR') {
            steps {
                script {
                    withAWS(region: "${AWS_REGION}", credentials: 'aws-credentials-id') {
                        sh 'aws ecr get-login-password | docker login --username AWS --password-stdin ${IMAGE_REPO_NAME}'
                        dockerImage.push()
                    }
                }
            }
        }

        stage('Deploy to ECS') {
            steps {
                script {
                    withAWS(region: "${AWS_REGION}", credentials: 'aws-credentials-id') {
                        sh '''
                        aws ecs update-service --cluster ${CLUSTER_NAME} --service ${SERVICE_NAME} --force-new-deployment
                        '''
                    }
                }
            }
        }
    }
}
