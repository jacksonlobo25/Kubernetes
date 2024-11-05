pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-credentials')
        KUBECONFIG = '/home/jackson/kubeconfig.yaml'
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
                        // Push the latest tag as well
                        sh "docker push ${IMAGE_NAME}:latest"
                    }
                }
            }
        }
        stage('Deploy to Kubernetes') {
            steps {
                script {
                    withCredentials([file(credentialsId: 'kubeconfig-file', variable: 'KUBECONFIG_FILE')]) {
                        sh "export KUBECONFIG=$KUBECONFIG_FILE"
                        
                        // Replace the image tags in mongo.yaml and spring.yaml with the new image and tag
                        sh """
                            sed -i 's|${IMAGE_NAME}:.*|${IMAGE_NAME}:${TAG}|g' mongo.yaml
                            sed -i 's|${IMAGE_NAME}:.*|${IMAGE_NAME}:${TAG}|g' spring.yaml
                        """

                        // Now apply the updated YAML files to Kubernetes
                        sh '''
                            kubectl apply -f mongo.yaml --validate=false
                            kubectl apply -f spring.yaml --validate=false
                        '''
                    }
                }
            }
        }
    }
}
