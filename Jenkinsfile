pipeline {
    agent any
    
    options {
        buildDiscarder(logRotator(numToKeepStr: '5'))
    }

    environment {
        DOCKERHUB_USERNAME = 'valeriivasianovych'
        APPLICATION_NAME = 'spring-boot-app'
        DOCKER_HUB_CREDENTIALS = credentials('dockerhub-credentials')
        IMAGE_TAG = 'latest'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Spring Boot App') {
            steps {
                script {
                    sh 'mvn clean package'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${DOCKERHUB_USERNAME}/${APPLICATION_NAME}:${IMAGE_TAG} ."
            }
        }

        stage('Test Docker Image') {
            steps {
                script {
                    def runningContainers = sh(script: "docker ps -q", returnStdout: true).trim()
                    if (runningContainers) {
                        sh "docker stop $runningContainers"
                    }
                    sh "docker run -d -p 8080:8080 ${DOCKERHUB_USERNAME}/${APPLICATION_NAME}:${IMAGE_TAG}"
                    sh "sleep 5"
                    sh """
                        if curl -I http://localhost:8080 | grep -q "200 OK"; then 
                            echo 'Test passed'; 
                        else 
                            echo 'Test failed'; 
                            exit 1; 
                        fi
                    """
                }
            }
        }

        stage('Login to Docker Hub') {
            steps {
                sh 'echo ${DOCKER_HUB_CREDENTIALS_PSW} | docker login -u ${DOCKERHUB_USERNAME} --password-stdin'
            }
        }

        stage('Push Docker Image') {
            steps {
                sh "docker push ${DOCKERHUB_USERNAME}/${APPLICATION_NAME}:${IMAGE_TAG}"
            }
        }

        stage('Notification') {
            steps {
                mail to: 'valerii.vasianovych.2003@gmail.com',
                    subject: "Build Successful: ${currentBuild.fullDisplayName}",
                    body: 'Docker Image has been pushed to Docker Hub'
            }
        }
    }

    post {
        always {
            sh "docker logout"
            sh "docker stop \$(docker ps -q)"
        }
        failure {
            mail to: 'valerii.vasianovych.2003@gmail.com',
                subject: "Build Failed: ${currentBuild.fullDisplayName}",
                body: 'Docker Image has not been pushed to Docker Hub'
        }
    }
}
