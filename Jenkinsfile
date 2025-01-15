pipeline {
    agent { label 'jenkins-agent' }
    tools {
        jdk 'Java17'
        maven 'Maven3'
    }
    environment{
        APP_NAME = "register-app-pipeline"
        RELEASE = "1.0.0"
        DOCKER_USER = "devopsuser1911"
        DOCKER_PASS = "dockerhub"
        IMAGE_NAME = "${DOCKER_USER}" + "/" + "${APP_NAME}"
        IAMGE_TAEG = "${RELEASE}-${BUILD_NUMBER}"
    }
    stages {
        stage("Cleanup Workspace"){
                steps {
                cleanWs()
                }
        }
        stage("Checkout from SCM"){
                steps {
                git branch: 'main', credentialsId: 'github', url: 'https://github.com/sandeepsuman1911/register_app' 
                }
        }
        stage("Build the Application"){
                steps {
                    sh "mvn clean package"
                }
        }
        stage("Test the Application"){
                steps {
                    sh "mvn test"
                }
        }
        stage("Sonarqube Analysis"){
            steps {
            script {
                withSonarQubeEnv(credentialsId: 'jenkins-sonarqube-token'){
                sh "mvn sonar:sonar"
                }
              }
            }
        }
        stage("Quality Gate"){
            steps {
                script {
                    waitForQualityGate abortPipeline: false, credentialsId: 'jenkins-sonarqube-token'
                }
            }
        }
        stage("Build & Push Docker Image"){
            steps {
                script {
                    docker.withRegistry('',DOCKER_PASS) {
                        docker_image = docker.build "${IMAGE_NAME}"
                    }
                    docker.withRegistry('',DOCKER_PASS) {
                        docker_image.push("${IMAGE_TAG}")
                        docker_iamge.push('latest')
                    }
                }
            }  
        }
    }
}
