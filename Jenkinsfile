pipeline {
  agent any
  stages {
    stage('Clone repository') {
      steps {
        deleteDir()
        git(branch: 'main', credentialsId: 'github', url: 'https://github.com/andrejwastaken/KIII')
      }
    }

    stage('Build image') {
      steps {
        sh 'docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .'
      }
    }

    stage('Push image') {
      steps {
        withCredentials(bindings: [usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'DOCKERHUB_USER', passwordVariable: 'DOCKERHUB_PASS')]) {
          sh 'echo "${DOCKERHUB_PASS}" | docker login -u "${DOCKERHUB_USER}" --password-stdin'
          sh 'docker push ${IMAGE_NAME}:${IMAGE_TAG}'
          sh 'docker logout'
        }

      }
    }

  }
  environment {
    IMAGE_NAME = 'andrejristikj/kii-demo-2'
    IMAGE_TAG = "${env.BUILD_NUMBER}"
  }
}
