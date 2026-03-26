pipeline {
	agent any
	environment {
		IMAGE_NAME = 'andrejristikj/kii-nginx-demo'
		IMAGE_TAG  = "${env.BUILD_NUMBER}"
	}
	stages {
		stage('Clone repository') {
			steps {
				deleteDir()
				git branch: 'main', credentialsId: 'github-token', url: 'https://github.com/andrejristikj/KII.git'
			}
		}
		stage('Build image') {
			steps {
				sh 'docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .'
			}
		}
		stage('Push image') {
			steps {
				withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKERHUB_USER', passwordVariable: 'DOCKERHUB_PASS')]) {
					sh 'echo "${DOCKERHUB_PASS}" | docker login -u "${DOCKERHUB_USER}" --password-stdin'
					sh 'docker push ${IMAGE_NAME}:${IMAGE_TAG}'
					sh 'docker logout'
				}
			}
		}
	}
}
