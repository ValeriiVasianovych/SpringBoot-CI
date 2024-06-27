# SpringBoot Continuous Integration (CI) with Jenkins and Docker

## Overview

This project demonstrates a CI/CD pipeline for a SpringBoot application using Jenkins, Docker, and ArgoCD. The pipeline performs the following steps:

1. When changes are pushed to the master branch of the SpringBoot app repository on GitHub, Jenkins triggers the CI process.
2. Jenkins checks out the code, builds the project using Maven, creates a Docker image, and runs the container.
3. Jenkins verifies that the application is running on port 8080.
4. Upon successful verification, Jenkins pushes the Docker image to DockerHub and sends a notification email.
5. ArgoCD, running in an EKS cluster, detects the new image version and deploys it using Helm charts.

## Prerequisites

- **Jenkins**: For automating the CI process.
- **Docker**: To build and run Docker images.
- **DockerHub**: To store and distribute Docker images.
- **GitHub Repository**: To host the source code of the SpringBoot application.
- **EKS Cluster**: Amazon Elastic Kubernetes Service for deploying the application.
- **ArgoCD**: A continuous delivery tool for Kubernetes.
- **Helm**: To manage Kubernetes applications.
- **SpringBoot Application**: The application codebase to be built and deployed.

## Conclusion

This project demonstrates a complete CI/CD pipeline for a SpringBoot application using Jenkins, Docker, DockerHub, and ArgoCD. The pipeline ensures that changes are automatically built, tested, and deployed to the Kubernetes cluster with minimal manual intervention.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.