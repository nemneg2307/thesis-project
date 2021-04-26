pipeline {
    agent any
    tools {
        maven 'Maven'
    }

    stages {
        stage("post-link"){
            steps {
                echo 'posting the link to slack...'
            }
            post {
                always {
                    slackSend (color: '#FFFFFF', message: "(${env.BUILD_URL})")
                }
            }
        }

        stage("build"){
            steps {
                echo 'building the app...'
                sh 'mvn clean compile'
            }
            post {

                failure{
                    slackSend (color: '#FF0000', message: "Build ${env.JOB_NAME}[${env.BUILD_NUMBER}] FAILED")
                }
                success{
                    slackSend (color: '#008000', message: "Build ${env.JOB_NAME}[${env.BUILD_NUMBER}] SUCCEEDED")
                }
                unstable{
                    slackSend (color: '#FFFF00', message: "Build ${env.JOB_NAME}[${env.BUILD_NUMBER}] UNSTABLE")
                }
            }
        }

        stage("test"){
            steps {
                echo 'testing the app...'
                sh 'mvn test'
            }
            post {
                always {
                    junit 'target/surefire-reports/*.xml'
                }
                failure{

                    slackSend (color: '#FF0000', message: "Test ${env.JOB_NAME}[${env.BUILD_NUMBER}] FAILED")
                }
                success{
                    slackSend (color: '#008000', message: "Test ${env.JOB_NAME}[${env.BUILD_NUMBER}] SUCCEEDED")
                }
                unstable{
                    slackSend (color: '#FFFF00', message: "Test ${env.JOB_NAME}[${env.BUILD_NUMBER}] UNSTABLE")
                }
            }
        }

        stage("deploy"){
            steps {
                echo 'deploying the app...'
                sh 'mvn deploy'
            }
        }
    }
}
