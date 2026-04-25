pipeline {
    agent any

    environment {
        PROJECT_ID = "machine-494406"
    }

    stages {

        stage('Checkout Code') {
            steps {
                echo "Checking out repository..."
                // optional if using SCM
            }
        }

        stage('Authenticate to GCP using Workload Identity') {
            steps {
                withCredentials([file(credentialsId: 'gcp-wif', variable: 'GOOGLE_APPLICATION_CREDENTIALS')]) {
                    sh '''
                    echo "Authenticating with GCP..."
                    
                    gcloud auth login --cred-file=$GOOGLE_APPLICATION_CREDENTIALS
                    
                    gcloud config set project $PROJECT_ID
                    
                    echo "Authentication successful"
                    '''
                }
            }
        }

        stage('Verify Access') {
            steps {
                sh '''
                echo "Listing Compute Instances..."
                gcloud compute instances list || echo "No instances found"
                '''
            }
        }

        stage('Terraform Init') {
            steps {
                sh '''
                echo "Initializing Terraform..."
                terraform init
                '''
            }
        }

        stage('Terraform Validate') {
            steps {
                sh '''
                echo "Validating Terraform..."
                terraform validate
                '''
            }
        }

        stage('Terraform Plan') {
            steps {
                sh '''
                echo "Planning Terraform..."
                terraform plan -out=tfplan
                '''
            }
        }

        stage('Terraform Apply') {
            steps {
                sh '''
                echo "Applying Terraform..."
                terraform apply -auto-approve tfplan
                '''
            }
        }
    }

    post {
        always {
            echo "Pipeline completed"
        }
        success {
            echo "SUCCESS: Infrastructure deployed"
        }
        failure {
            echo "FAILED: Check logs"
        }
    }
}
