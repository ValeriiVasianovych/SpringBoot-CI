pipeline {
    agent any
    
    options {
        buildDiscarder(logRotator(numToKeepStr: '5'))
    }

    environment {
        DOCKERHUB_USERNAME = 'valeriivasianovych'
        APPLICATION_NAME = 'spring-boot-app'
        DOCKER_HUB_CREDENTIALS = credentials('dockerhub-credentials')
        IMAGE_TAG = "${env.BUILD_NUMBER}"
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
        }
        failure {
            mail to: 'valerii.vasianovych.2003@gmail.com',
                subject: "Build Failed: ${currentBuild.fullDisplayName}",
                body: 'Docker Image has not been pushed to Docker Hub'
        }
    }
}
