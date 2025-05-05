pipeline {
    agent any
    tools {
        maven "M3"
    }
    stages {
        stage('Check Java Version') {
            steps {
                sh 'java -version'
            }
        }
        stage('Build Maven') {
            steps {
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/sublime-exp/devops-automation']])
                sh "mvn clean install"
            }
        }
        stage('Extract Maven Version') {
            steps {
                script {
                    // Extract the version from the pom.xml (this assumes your version is in the <version> tag)
                    def mavenVersion = sh(script: "mvn help:evaluate -Dexpression=project.version -q -DforceStdout", returnStdout: true).trim()
                    // Use the Maven version as the Docker image tag
                    env.IMAGE_TAG = "ivakis/devops-integration:${mavenVersion}"
                    echo "Using Maven version as Docker tag: ${env.IMAGE_TAG}"
                }
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    // Use the Maven version-based tag
                    sh "docker build -t ${env.IMAGE_TAG} ."
                }
            }
        }
        stage('Push Image to Hub') {
            steps {
                script {
                    withCredentials([string(credentialsId: 'dockerhub-pwd', variable: 'dockerhubpwd')]) {
                        sh '''
                            echo "$dockerhubpwd" | docker login -u ivakis --password-stdin
                            docker push ${env.IMAGE_TAG}
                        '''
                    }
                }
            }
        }
        stage('Cleanup Docker Images') {
            steps {
                script {
                    // Clean up the locally built image
                    sh "docker rmi ${env.IMAGE_TAG} || true"
                }
            }
        }
        stage('Deploy to K8S') {
            steps {
                sh 'kubectl apply -f deployment.yml'
            }
        }
    }
}
