pipeline {
    agent any

    environment {
        DEV_IMAGE = "dharineesh01/dev:latest"
        PROD_IMAGE = "dharineesh01/prod:latest"
        REPO_URL  = "https://github.com/dharineesh16/devops-build.git"
    }

    stages {
        stage('Checkout') {
            steps {
                echo "Checking out branch ${env.BRANCH_NAME}"
                checkout([$class: 'GitSCM',
                    branches: [[name: "*/${env.BRANCH_NAME}"]],
                    userRemoteConfigs: [[url: "${REPO_URL}"]]
                ])
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    if (env.BRANCH_NAME == "dev") {
                        echo "Building Docker image for DEV"
                        sh "./build.sh dev"
                    } else if (env.BRANCH_NAME == "main") {
                        echo "Building Docker image for PROD"
                        sh "./build.sh main"
                    } else {
                        echo "Skipping build for branch ${env.BRANCH_NAME}"
                    }
                }
            }
        }

        stage('Push to Docker Hub') {
            when { expression { env.BRANCH_NAME == 'dev' || env.BRANCH_NAME == 'main' } }
            steps {
                withCredentials([usernamePassword(credentialsId: 'Credentials', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    script {
                        echo "Logging in to Docker Hub..."
                        sh 'echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin'

                        if (env.BRANCH_NAME == "dev") {
                            echo "Pushing DEV image..."
                            sh "docker push ${DEV_IMAGE}"
                        } else if (env.BRANCH_NAME == "main") {
                            echo "Pushing PROD image..."
                            sh "docker push ${PROD_IMAGE}"
                        }
                    }
                }
            }
        }

        stage('Deploy Application') {
            when { expression { env.BRANCH_NAME == 'dev' || env.BRANCH_NAME == 'main' } }
            steps {
                script {
                    if (env.BRANCH_NAME == "dev") {
                        echo "Deploying DEV container..."
                        sh """
                            docker rm -f react-app-dev || true
                            docker run -d --name react-app-dev -p 3001:3000 ${DEV_IMAGE}
                        """
                    } else if (env.BRANCH_NAME == "main") {
                        echo "Deploying PROD container..."
                        sh """
                            docker rm -f react-app-prod || true
                            docker run -d --name react-app-prod -p 3002:3000 ${PROD_IMAGE}
                        """
                    }
                }
            }
        }
    }

    post {
        success {
            echo "✅ Pipeline completed successfully for ${env.BRANCH_NAME}"
        }
        failure {
            echo "❌ Pipeline failed for ${env.BRANCH_NAME}"
        }
    }
}
