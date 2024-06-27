# SpringBoot CI/CD with Jenkins and Argo CD on Amazon EKS

This project demonstrates a CI/CD pipeline using Spring Boot application, Jenkins, Docker/Dockerhub, Helm and Argo CD, Kubernetes on EKS.

## Preview
![project](img/preview.jpg)

## Technologies Used
**Spring Boot:** Spring Boot is an open-source Java-based framework used to create micro-services and stand-alone Java applications.
**Jenkins:** Jenkins is an open-source automation server that helps to automate the non-human part of the software development process.
**Docker:** Docker is a platform for developing, shipping, and running applications in containers.
**DockerHub:** DockerHub is a cloud-based repository in which Docker users and partners create, test, store, and distribute container images.
**Argo CD:** Argo CD is a declarative, GitOps continuous delivery tool for Kubernetes.
**Helm:** Helm is a package manager for Kubernetes that allows developers and operators to more easily package, configure, and deploy applications and services onto Kubernetes clusters.
**Kubernetes:** Kubernetes is an open-source container-orchestration system for automating computer application deployment, scaling, and management.
**Amazon EKS:** Amazon Elastic Kubernetes Service (Amazon EKS) is a managed service that makes it easy for you to run Kubernetes on AWS without needing to install, operate, and maintain your own Kubernetes control plane.
**2 GitHub Repositories:** One for the Spring Boot application and the other for Argo CD Helm Charts.

## Part 1: SpringBoot CI

This part focuses on Continuous Integration using Jenkins and Docker.

### Steps Involved:

1. **SpringBoot App Development:**
   - Develop Spring Boot application locally.

2. **Push to GitHub:**
   - Push changes to a GitHub repository (`https://github.com/ValeriiVasianovych/SpringBoot-CI-CD`).

3. **Jenkins Pipeline:**
   - Jenkins is configured to monitor the `https://github.com/ValeriiVasianovych/SpringBoot-CI-CD` repository.
   - On a `git push` event to `master`, Jenkins performs the following steps:
     - Checks out the latest code.
     - Runs Maven (`mvn clean package`) to build the application.
     - Builds a Docker image.
     - Pushes the Docker image to DockerHub.
     - Sends a notification email upon successful completion.

## Part 2: SpringBoot GitOps CD

This part focuses on Continuous Deployment using Argo CD and Helm Charts on Amazon EKS.

### Steps Involved:

1. **Deployment Repository Setup:**
   - Separate GitHub repository (`https://github.com/ValeriiVasianovych/ArgoCD-Helm-Charts`) for storing Argo CD Helm Charts.

2. **Argo CD Configuration:**
   - Configure Argo CD on EKS cluster (`https://github.com/ValeriiVasianovych/ArgoCD-Helm-Charts`).
   - Argo CD monitors changes to the Helm Charts repository.

3. **Continuous Deployment:**
   - Argo CD detects the new image version in the Helm Charts repository.
   - It deploys the updated application to the EKS cluster automatically.

### Repository Links:

- **SpringBoot App Repository:**
  - Repository: `https://github.com/ValeriiVasianovych/SpringBoot-CI-CD`
  - [GitHub](https://github.com/ValeriiVasianovych/SpringBoot-CI-CD)

- **Argo CD Helm Charts Repository:**
  - Repository: `https://github.com/ValeriiVasianovych/ArgoCD-Helm-Charts`
  - [GitHub](https://github.com/ValeriiVasianovych/ArgoCD-Helm-Charts)

### License:

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.