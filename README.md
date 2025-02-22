# Word Count API - CI/CD with Jenkins, Docker, and Kubernetes



**Overview**

This project sets up a FastAPI-based Word Count Application deployed in Kubernetes using Jenkins for CI/CD. The pipeline automatically builds a Docker image, pushes it to a container registry, and deploys it to a Kubernetes cluster when code changes.

**Technologies Used**

Python (FastAPI) - Backend API

Docker - Containerization

Jenkins - CI/CD automation

Kubernetes - Deployment & orchestration

AWS-EKS
**Automating Deployment in Kubernetes**

With the Jenkinsfile setup, every code change will:
✅ Trigger a Docker image build
✅ Push the new image to Docker Hub
✅ Update the Kubernetes deployment with the latest image
✅ Restart the service to apply changes
