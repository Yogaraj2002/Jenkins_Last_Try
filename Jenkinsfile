pipeline {
    agent any

    stages {
        stage('Checkout From GitHub') {
            steps {
                checkout scm
            }
        }

        stage('Verify SF CLI') {
            steps {
                bat 'sf --version'
            }
        }

        stage('Authenticate Salesforce') {
            steps {
                withCredentials([string(credentialsId: 'sf-auth-url', variable: 'SF_AUTH_URL')]) {
                    writeFile file: 'sfdx_auth.txt', text: SF_AUTH_URL
                    bat 'sf org login sfdx-url --sfdx-url-file sfdx_auth.txt --alias JenkinsOrg --set-default'
                    bat 'del sfdx_auth.txt'
                }
            }
        }

        stage('Verify Org Connection') {
            steps {
                bat 'sf org list'
            }
        }

      stage('Deploy Apex Classes') {
            steps {
                // Change 'JenkinsSFDeploy' to whatever name you used in the 'sf project generate' command
                dir('JenkinsSFDeploy') {
                    bat '''
                    sf project deploy start ^
                    --metadata ApexClass:HelloWorldService ^
                    --metadata ApexClass:HelloWorldServiceTest ^
                    --target-org yogi81102.3781dfe9b859@agentforce.com ^
                    --test-level RunSpecifiedTests ^
                    --tests HelloWorldServiceTest ^
                    --wait 60
                    '''
                }
            }
        }
    }

    post {
        success {
            echo 'Deployment Successful!'
        }
        failure {
            echo 'Deployment Failed.'
        }
    }
}
