pipeline {
    agent any

    environment {
        IMAGE_NAME = "konrad84kb/discovery-service"
        IMAGE_TAG = "latest"
        GIT_REPO = "https://github.com/konrad84kb/discovery-service.git"
    }

    stages {
        stage('Clone') {
            steps {
                sh "git clone $GIT_REPO"
            }
        }

        stage('Build App') {
            steps {
                dir('discovery-service') {
                    sh './mvnw clean package -DskipTests'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE_NAME:$IMAGE_TAG discovery-service/'
            }
        }

        stage('Push to DockerHub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                    sh 'echo $PASS | docker login -u $USER --password-stdin'
                    sh 'docker push $IMAGE_NAME:$IMAGE_TAG'
                }
            }
        }
    }
}
