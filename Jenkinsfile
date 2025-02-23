pipeline {
    agent any

    environment {
        IMAGE_NAME = "word-count-api"
        DOCKER_REGISTRY = "your-dockerhub-username" // Change for private registry
        DOCKER_TAG = "latest"
        KUBERNETES_DEPLOYMENT = "word-count-app"  // Name of your K8s deployment
    }

    stages {
        stage('Clone Repository') {
            steps {
		script {
                    // Ensures the workspace is clean before cloning
                    sh "rm -rf *"
                }
                git branch: 'main', url: 'https://github.com/dvrkittu/word-count/'
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
	            withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', 
	                                             usernameVariable: 'DOCKER_USERNAME', 
	                                             passwordVariable: 'DOCKER_PASSWORD')]) 
			{
	                sh "echo ${DOCKER_PASSWORD} | docker login -u ${DOCKER_USERNAME} --password-stdin"
	                sh "docker push ${DOCKER_REGISTRY}/${IMAGE_NAME}:${DOCKER_TAG}"
	            }
	        }
	    }
	}
	        stage('Deploy to Kubernetes') {
            steps {
                script {
                    sh """
	            kubectl config set-context <your-k8s-context>
                    kubectl set image deployment/${KUBERNETES_DEPLOYMENT} word-count-api=${DOCKER_REGISTRY}/${IMAGE_NAME}:${DOCKER_TAG}
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
