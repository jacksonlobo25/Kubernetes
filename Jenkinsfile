pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-credentials')
        KUBECONFIG = '~/.kube/config'
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
                    }
                }
            }
        }
        stage('Deploy to Kubernetes') {
            // steps {
                // script {
                //     withCredentials([string(credentialsId: 'k8s-service-account-token', variable: 'KUBE_TOKEN')]) {
                //         sh '''#!/bin/bash
                //         # Set the Kubernetes credentials using the token
                //         kubectl config set-credentials jenkins --token=$KUBE_TOKEN
                        
                //         # Set the context to point to the appropriate cluster and use the jenkins user
                //         kubectl config set-context jenkins-context --user=jenkins --cluster=kubernetes

                //         # Use the context you just set
                //         kubectl config use-context jenkins-context

                //         # Apply the Kubernetes manifests
                //         kubectl apply -f mongo.yaml
                //         kubectl apply -f spring.yaml
                //         '''
                //     }
                // }
                steps {
                    withKubeConfig([credentialsId: 'KUBECONFIG']) {
                    sh 'kubectl apply -f mongo.yaml'
                    }
                }
            // }
        }
    }
}
