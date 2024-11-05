pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-credentials')
        KUBE_CONFIG_CREDENTIALS_ID = credentials('k8s-service-account-token') 
        IMAGE_NAME = "jacksonlobo/springboot-app"
        TAG = "${env.BUILD_NUMBER}"
    }

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t ${IMAGE_NAME}:${TAG} backend/"
                    sh "docker tag ${IMAGE_NAME}:${TAG} ${IMAGE_NAME}:latest"
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
                        sh "echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin"
                        sh "docker push ${IMAGE_NAME}:${TAG}"
                        // sh "docker push ${IMAGE_NAME}:latest"
                    }
                }
            }
        }
        stage('Deploy MongoDB') {

            steps {

                withCredentials([kubeconfig(credentialsId: KUBE_CONFIG_CREDENTIALS_ID)]) {

                    sh "kubectl apply -f mongo.yaml"

                }

            }

        }
 
        stage('Deploy Spring Boot App') {

            steps {

                withCredentials([kubeconfig(credentialsId: KUBE_CONFIG_CREDENTIALS_ID)]) {

                    sh "kubectl apply -f spring.yaml"

                }

            }

        }
    }
}
