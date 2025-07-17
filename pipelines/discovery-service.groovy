pipeline {
    agent any
    environment {
        REPO_URL = 'https://github.com/konrad/discovery-service.git'
        SERVICE = 'discovery-service'
        IMAGE = "ghcr.io/konrad/${SERVICE}"
        TAG = sh(script: "git rev-parse --short HEAD", returnStdout: true).trim()
    }
    stages {
        stage('Clone repo') {
            steps {
                sh "git clone ${REPO_URL}"
            }
        }
        stage('Build Docker image') {
            steps {
                sh "docker build -t ${IMAGE}:${TAG} ${SERVICE}/"
            }
        }
        stage('Push image') {
            steps {
                withDockerRegistry([credentialsId: 'ghcr-creds']) {
                    sh "docker push ${IMAGE}:${TAG}"
                }
            }
        }
        stage('Update values.yaml via PR') {
            steps {
                sh '''
          git config --global user.name "CI Bot"
          git config --global user.email "ci@infra.local"
          git clone https://github.com/konrad/infra.git
          cd infra
          yq e ".discovery-service.image.tag = \\"${TAG}\\"" -i helm/umbrella/values.yaml
          git checkout -b update-discovery-service-${TAG}
          git commit -am "Update discovery-service image tag to ${TAG}"
          git push origin update-discovery-service-${TAG}
          gh pr create --title "Update discovery-service tag" --body "Auto-generated PR by pipeline"
        '''
            }
        }
    }
}
