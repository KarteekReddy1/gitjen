pipeline {
    agent any

    environment {
        PROJECT_ID = "machine-494406"
        GCLOUD = "gcloud"
    }

    stages {

        stage('Verify ADC Auth') {
            steps {
                bat '''
                echo ===== VERIFY ADC =====

                gcloud auth application-default print-access-token

                gcloud config set project %PROJECT_ID%

                gcloud compute instances list
                '''
            }
        }

        stage('Terraform Init') {
            steps {
                bat 'terraform init'
            }
        }

        stage('Terraform Validate') {
            steps {
                bat 'terraform validate'
            }
        }

        stage('Terraform Plan') {
            steps {
                bat 'terraform plan -out=tfplan'
            }
        }

        stage('Terraform Apply') {
            steps {
                input message: 'Apply Terraform plan?', ok: 'Apply'
                bat 'terraform apply -auto-approve tfplan'
            }
        }
    }
}
