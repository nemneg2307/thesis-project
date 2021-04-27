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
                sh 'mvn clean install'
            }
            post {

                failure{
                    slackSend (color: '#FF0000', message: "|Build___| ${env.JOB_NAME}[${env.BUILD_NUMBER}] FAILED")
                }
                success{
                    slackSend (color: '#008000', message: "|Build___| ${env.JOB_NAME}[${env.BUILD_NUMBER}] SUCCEEDED")
                }
                unstable{
                    slackSend (color: '#FFFF00', message: "|Build___| ${env.JOB_NAME}[${env.BUILD_NUMBER}] UNSTABLE")
                }
            }
        }

        stage("test"){
            steps {
                echo 'testing the app...'
                sh 'mvn test'
            }
            post {

                failure{

                    slackSend (color: '#FF0000', message: "|Test____| ${env.JOB_NAME}[${env.BUILD_NUMBER}] FAILED")
                }
                success{
                    slackSend (color: '#008000', message: "|Test____| ${env.JOB_NAME}[${env.BUILD_NUMBER}] SUCCEEDED")
                }
                unstable{
                    slackSend (color: '#FFFF00', message: "|Test___| ${env.JOB_NAME}[${env.BUILD_NUMBER}] UNSTABLE")
                }
            }
        }

        stage("package"){
            steps {
                echo 'packaging the app...'
                sh 'mvn package'
            }
            post {

                failure{
                    slackSend (color: '#FF0000', message: "|Package| ${env.JOB_NAME}[${env.BUILD_NUMBER}] FAILED")
                }
                success{
                    slackSend (color: '#008000', message: "|Package| ${env.JOB_NAME}[${env.BUILD_NUMBER}] SUCCEEDED")
                }
                unstable{
                    slackSend (color: '#FFFF00', message: "|Package| ${env.JOB_NAME}[${env.BUILD_NUMBER}] UNSTABLE")
                }
            }
        }

        stage("deploy"){
            steps {
                echo 'deploying the app...'
                deploy adapters: [tomcat9(url: 'http://dev-jenkins.duckdns.org:8082',
                                              credentialsId: 'deploy user')],
                                     war: '**/*.war',
                                     contextPath: 'war-build'
                script {
                    if (env.BRANCH_NAME == 'main') {
                        deploy adapters: [tomcat9(url: 'http://dev-jenkins.duckdns.org:8082',
                                                                      credentialsId: 'deploy user')],
                                                             war: '**/*.war',
                                                             contextPath: 'war-build'
                    } else if (env.BRANCH_NAME == 'develop') {
                        slackSend (color: '#008000', message: "All is good! You can create pull request now!")
                    }
                }
            }
            post {

                failure{
                    script {
                        if (env.BRANCH_NAME == 'main') {
                            slackSend (color: '#FF0000', message: "|Deploy_| ${env.JOB_NAME}[${env.BUILD_NUMBER}] FAILED")
                        }
                    }
                }
                success{
                    script {
                        if (env.BRANCH_NAME == 'main') {
                            slackSend (color: '#008000', message: "|Deploy_| ${env.JOB_NAME}[${env.BUILD_NUMBER}] SUCCEEDED \nhttp://dev-jenkins.duckdns.org:8082/war-build/")
                        }
                    }

                }
                unstable{
                    script {
                        if (env.BRANCH_NAME == 'main') {
                            slackSend (color: '#FFFF00', message: "|Deploy_| ${env.JOB_NAME}[${env.BUILD_NUMBER}] UNSTABLE")
                        }
                    }

                }
            }
        }
    }
}
