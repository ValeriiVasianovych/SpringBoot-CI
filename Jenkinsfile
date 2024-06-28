pipeline {
    agent any
    
    options {
        buildDiscarder(logRotator(numToKeepStr: '5'))
    }

    environment {
        DOCKERHUB_USERNAME     = "valeriivasianovych"
        APPLICATION_NAME       = "spring-boot-app"
        DOCKER_HUB_CREDENTIALS = credentials('dockerhub-credentials')
        IMAGE_TAG              = "${env.BUILD_NUMBER}"
        REPO_URL               = "git@github.com:ValeriiVasianovych/ArgoCD-Helm-Charts.git"
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

        stage('Update image version for ArgoCD in other repository') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'github-credentials', usernameVariable: 'GITHUB_USERNAME', passwordVariable: 'GITHUB_PASSWORD')]) {
                    sh 'git config --global user.email "valerii.vasianovych.2003@gmail.com"'
                    sh 'git config --global user.name "ValeriiVasianovych"'

                    script {
                        sh 'git clone ${REPO_URL}'
                        dir('ArgoCD-Helm-Charts') {
                            sh "sed -i 's|valeriivasianovych/spring-boot-app:.*|valeriivasianovych/spring-boot-app:${IMAGE_TAG}|' ArgoCD-Helm/cluster/applications/springbootapp/app2.yaml"
                            sh "git add ArgoCD-Helm/cluster/applications/springbootapp/app2.yaml"
                            sh "git commit -m \"Update image version to ${IMAGE_TAG}\""
                            sh "git push origin master"
                        }
                    }
                }
            }
        }

        stage('Notification') {
            steps {
                mail to: 'valerii.vasianovych.2003@gmail.com',
                    subject: "Build Successful: ${currentBuild.fullDisplayName}",
                    body: 'Docker Image has been pushed to Docker Hub and ArgoCD application has been updated'
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
                body: 'Docker Image has not been pushed to Docker Hub or ArgoCD application update failed'
        }
    }
}
