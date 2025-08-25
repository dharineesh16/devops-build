pipeline {
    agent any

    environment {
        DOCKER_DEV = "dharineesh01/dev:latest"
        DOCKER_PROD = "dharineesh01/prod:latest"
        REPO_URL = "https://github.com/dharineesh16/devops-build.git"
    }

    stages {
        stage('Checkout') {
            steps {
                echo "Checking out branch ${BRANCH_NAME}"
                git branch: "${BRANCH_NAME}", url: "${REPO_URL}"
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "Building Docker image for ${BRANCH_NAME}"
                sh "./build.sh ${BRANCH_NAME}"
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    if (BRANCH_NAME == 'dev') {
                        echo "Pushing image to Docker Hub dev repo"
                        sh "docker push ${DOCKER_DEV}"
                    } else if (BRANCH_NAME == 'main') {
                        echo "Pushing image to Docker Hub prod repo"
                        sh "docker push ${DOCKER_PROD}"
                    }
                }
            }
        }

        stage('Deploy Application') {
            steps {
                echo "Deploying application for ${BRANCH_NAME}"
                sh "./deploy.sh ${BRANCH_NAME}"
            }
        }
    }

    post {
        success {
            echo "✅ Pipeline completed successfully for ${BRANCH_NAME}"
        }
        failure {
            echo "❌ Pipeline failed for ${BRANCH_NAME}"
        }
    }
}
