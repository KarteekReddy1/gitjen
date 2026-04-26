pipeline {
    agent any
    environment {
        GOOGLE_APPLICATION_CREDENTIALS = credentials('gcp-wif')
        GOOGLE_EXTERNAL_ACCOUNT_ALLOW_EXECUTABLES = '1'
}

    }
    stages {
        stage('Checkout') {
            steps {
                git branch: 'master', url: 'https://github.com/KarteekReddy1/gitjen.git'
            }
        }
        stage('Terraform Init') {
            steps {
                sh 'terraform init'
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
