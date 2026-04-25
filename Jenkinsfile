pipeline {
    agent any

    stages {
        stage('Terraform Init') {
            steps {
                withCredentials([file(credentialsId: 'jenkins-oidc-config', variable: 'OIDC_CONFIG')]) {
                    sh '''
                      export GOOGLE_APPLICATION_CREDENTIALS=$OIDC_CONFIG
                      terraform init
                    '''
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                sh 'terraform plan'
            }
        }

        stage('Terraform Apply') {
            steps {
                sh 'terraform apply -auto-approve'
            }
        }
    }
}
