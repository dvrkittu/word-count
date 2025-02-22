pipeline {
    agent any

    environment {
        IMAGE_NAME = "word-count-api"
        DOCKER_REGISTRY = "your-dockerhub-username" // Change for private registry
        DOCKER_TAG = "latest"
        KUBERNETES_DEPLOYMENT = "word-count-app"  // Name of your K8s deployment        TARGET_BRANCH = "main"  // Change this to your desired branch
    }

    stages {
        stage('Clone Repository') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t ${DOCKER_REGISTRY}/${IMAGE_NAME}:${DOCKER_TAG} ."
                }
            }
        }

        stage('Push to Docker Registry') {
            steps {
                script {
                    sh "echo ${DOCKER_PASSWORD} | docker login -u ${DOCKER_USERNAME} --password-stdin"
                    sh "docker push ${DOCKER_REGISTRY}/${IMAGE_NAME}:${DOCKER_TAG}"
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    sh """
					kubectl config set-context <your-k8s-context>
                    kubectl set image deployment/${KUBERNETES_DEPLOYMENT} word-count-api=${DOCKER_REGISTRY}/${IMAGE_NAME}:${DOCKER_TAG}
                    kubectl rollout status deployment/${KUBERNETES_DEPLOYMENT}
                    """
                }
            }
        }
    }

    post {
        always {
            echo "Pipeline execution completed!"
        }
    }
}
