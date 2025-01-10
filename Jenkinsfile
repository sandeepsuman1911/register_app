pipeline {
    agent { label 'jenkins-agent' }
    tools {
        jdk 'Java17'
        maven 'Maven3'
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
                withSonarQubeEnv(credentialsId: 'Jenkins-Sonarqube_Token'){
                sh "mvn sonar:sonar"
                }
              }
            }
        }
    }
}
