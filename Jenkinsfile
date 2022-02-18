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
                sh 'terraform apply -auto-approve '
                sh 'terraform output >../output.txt'
            }
        }
        stage('Update Lambda ENV ') {
            steps {
                sh'cat ../output.txt | tr -d \' "\'>environment.txt'
                withEnv(readFile('environment.txt').split('\n') as List) {
                    sh "echo ${matchengine_URL}"
                    sh "echo ${walletapp_URL}"
                    sh "echo ${prodDB_URL}"
                   
                    
                    sh 'aws lambda update-function-configuration --function-name user-create-user --environment \'{"Variables":{"prodDB_URL":"\'${prodDB_URL%:*}\'"}}\''
                     sh 'aws lambda update-function-configuration --function-name update-user --environment \'{"Variables":{"prodDB_URL":"\'${prodDB_URL%:*}\'"}}\''
                     sh 'aws lambda update-function-configuration --function-name user-check-email --environment \'{"Variables":{"prodDB_URL":"\'${prodDB_URL%:*}\'"}}\''
                     sh 'aws lambda update-function-configuration --function-name current-user --environment \'{"Variables":{"prodDB_URL":"\'${prodDB_URL%:*}\'"}}\''
                    sh 'aws lambda update-function-configuration --function-name authenticate-user --environment \'{"Variables":{"prodDB_URL":"\'${prodDB_URL%:*}\'"}}\''
                    
                }
            }
        }
         stage('Build and Deploy') {
           parallel{
               stage('wallet'){
                   stages{
                       stage ('Build and Deploy'){
                           steps{
                               build job: 'wallet', parameters: [string(name: 'param1', value: "value1")],propagate: true,wait: true
                           }
                       }
                       stage('Check Env Health') {
                            steps {
                                sh 'aws elasticbeanstalk describe-environment-health --environment-name walletapp-env --attribute-names Color | grep Green'
                             }
                        }
                    }

                }
               stage('matchEngine'){
                   stages{
                       stage ('Build and Deploy'){
                           steps{
                               build job: 'matchEngine', parameters: [string(name: 'param1', value: "value1")],propagate: true,wait: true
                           }
                       }
                       stage('Check Env Health') {
                            steps {
                                sh 'aws elasticbeanstalk describe-environment-health --environment-name matchengine-env --attribute-names Color | grep Green'
                             }
                        }
                   }
               }
               stage('front Angular'){
                   stages{
                       stage ('Build and Deploy'){
                           steps{
                               build job: 'front', parameters: [string(name: 'param1', value: "value1")],propagate: true,wait: true
                            }
                        }
                        stage('Check Env Health') {
                            steps {
                                sh 'aws elasticbeanstalk describe-environment-health --environment-name matchengine-env --attribute-names Color | grep Green'
                             }
                        }
                   }
               }
           }
        }
       
       
    }
}
