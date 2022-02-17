pipeline {
    agent any

     options {
        buildDiscarder(logRotator(numToKeepStr: '2', artifactNumToKeepStr: '2'))
    }
    environment {
        AWS_ACCESS_KEY_ID     = credentials('jenkins-aws-secret-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('jenkins-aws-secret-access-key')
        ARTIFACT_NAME = "matchengine-${BUILD_ID}.jar"
        AWS_S3_BUCKET = 'mydeploys3'
        AWS_EB_APP_NAME = '2-matchEngine'
        AWS_EB_ENVIRONMENT = '2matchengine-env'
        AWS_EB_APP_VERSION = "${BUILD_ID}-local"
        WALLET_URL = 'pas définie'
    }
 
    stages{
           
        stage('Checkout Project') {
            steps {
                echo "-=- Checout project -=-"
                git branch: 'master', credentialsId: 'jenkinsSSH', url: 'git@github.com:pharaphara/FullDeploy.git'
            }
        }
        stage('terraform INIT') {
            steps {
                sh 'terraform init'
            }
        }
        stage('terraform APPLY ') {
            steps {
                sh 'terraform apply -auto-approve -no-color'
                sh 'terraform output >output.txt'
            }
        }
        stage ('echo URL') {
            steps {
                sh 'ls'
                sh 'pwd'
                sh 'wallet=$(cat output.txt | grep "matchengine"|cut -d\'"\' -f 2)'
                sh 'echo ${wallet}'
                
            }
        }
        stage('Parallel Deployment') {
            steps {
                parallel(
                    'Deploy Wallet': {
                        build job: 'pipeline1', parameters: [
                            string(name: 'param1', value: "value1")
                        ],
                        propagate: true,
                        wait: true
                    },
                    'Deploy MatchEngine': {
                        build job: 'pipeline2', parameters: [
                            string(name: 'param1', value: "value1")
                        ],
                        propagate: true,
                        wait: true
                    }
                )
             }
        }
    }
}