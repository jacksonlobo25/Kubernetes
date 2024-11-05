pipeline {
    agent any

    parameters {
        // Define a choice parameter for environment (DEV or PROD)
        choice(name: 'ENVIRONMENT', choices: ['dev', 'prod'], description: 'Choose the deployment environment')
    }

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-credentials')
        KUBECONFIG = '/home/jackson/kubeconfig.yaml'
        KUBE_CONFIG_CREDENTIALS_ID = credentials('k8s-service-account-token') 
        IMAGE_NAME = "jacksonlobo/springboot-app"
        TAG = "${env.BUILD_NUMBER}"
    }

    stages {
        stage('Create Namespace') {
            steps {
                script {
                    // Get the selected environment (dev or prod)
                    def namespace = params.ENVIRONMENT
                    
                    // Check if the namespace exists, and create it if it does not
                    sh """
                        kubectl get namespace ${namespace} || kubectl create namespace ${namespace}
                    """
                }
            }
        }
        
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
                    // Get the selected environment (dev or prod)
                    def namespace = params.ENVIRONMENT
                    
                    // Check that the namespace is valid
                    if (namespace != 'dev' && namespace != 'prod') {
                        error "Invalid environment selected. Please choose either 'dev' or 'prod'."
                    }

                    // Update KUBECONFIG to use the credentials file
                    withCredentials([file(credentialsId: 'kubeconfig-file', variable: 'KUBECONFIG_FILE')]) {
                        sh "export KUBECONFIG=$KUBECONFIG_FILE"
                        
                        // Replace the image tags in mongo.yaml and spring.yaml with the new image and tag
                        sh """
                            sed -i 's|${IMAGE_NAME}:.*|${IMAGE_NAME}:${TAG}|g' mongo.yaml
                            sed -i 's|${IMAGE_NAME}:.*|${IMAGE_NAME}:${TAG}|g' spring.yaml
                        """
                        
                        // Deploy to the selected namespace (either 'dev' or 'prod')
                        sh """
                            kubectl apply -f mongo.yaml --namespace=${namespace} --validate=false
                            kubectl apply -f spring.yaml --namespace=${namespace} --validate=false
                        """
                    }
                }
            }
        }
    }
}
