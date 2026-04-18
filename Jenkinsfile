pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_Jenkins')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_Jenkins')
        AWS_DEFAULT_REGION    = 'us-east-1'
        TF_IN_AUTOMATION      = 'true'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Terraform Init') {
            steps {
                sh 'terraform init -input=false'
            }
        }

        stage('Terraform Validate') {
            steps {
                sh 'terraform validate'
            }
        }

        stage('Terraform Plan') {
            steps {
                sh 'terraform plan -out=tfplan -input=false'
            }
        }

        stage('Terraform Apply') {
            steps {
                input message: 'Apply Terraform changes?', ok: 'Apply'
                sh 'terraform apply -input=false tfplan'
            }
        }
    }

    post {
        always {
            sh 'rm -f tfplan'
        }
    }
}
