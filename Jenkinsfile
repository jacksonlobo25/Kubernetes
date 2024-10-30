pipeline {

    agent any
 
    environment {

        DOCKER_IMAGE_SPRING = jacksonlobo/springboot-app - Docker Image
        DOCKER_VERSION = 1.0.0

    }
 
    stages {
 
        stage('Build') {

            steps {
                sh 'echo success'
                sh './mvnw clean package -DskipTests'

            }

        }
 
        // stage('Build Docker Image') {

        //     steps {

        //         sh "docker build -t ${jacksonlobo/springboot-app - Docker Image}

        //     }

        // }
 
        // stage('Push Docker Image') {

        //     steps {

        //         sh 'echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin'

        //         sh "docker push ${jacksonlobo/springboot-app - Docker Image}"

        //     }

        // }
 
        // stage('Create Namespace') {

        //     steps {

        //         withCredentials([kubeconfig(credentialsId: KUBE_CONFIG_CREDENTIALS_ID)]) {

        //             sh "kubectl apply -f namespace.yaml"

        //         }

        //     }

        // }
 
        // stage('Deploy MongoDB') {

        //     steps {

        //         withCredentials([kubeconfig(credentialsId: KUBE_CONFIG_CREDENTIALS_ID)]) {

        //             sh "kubectl apply -f mongo.yaml -n ${K8S_NAMESPACE}"

        //         }

        //     }

        // }
 
        // stage('Deploy Spring Boot App') {

        //     steps {

        //         withCredentials([kubeconfig(credentialsId: KUBE_CONFIG_CREDENTIALS_ID)]) {

        //             sh "kubectl apply -f spring.yaml -n ${K8S_NAMESPACE}"

        //         }

        //     }

        // }

    }

}