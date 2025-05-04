pipeline {
    agent any
    tools {
        maven "M3"
    }
    stages {
        stage('Build Maven') {
            steps {
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/sublime-exp/devops-automation']])
                sh "mvn clean install"
            }
        }
        stage('Build Doker Image') {
            steps {
                script {
                    sh "docker build -t ivakis/devops-integration ."
                }
            }
        }
        stage('Push Image to Hub') {
            steps {
                script {
                    withCredentials([string(credentialsId: 'dockerhub-pwd', variable: 'dockerhubpwd')]) {
                    sh "docker login -u ivakis -p ${dockerhubpwd}"
                    sh "docker push ivakis/devops-integration"
                  }
                }
            }
        }
    }
}