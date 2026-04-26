pipeline {
    agent any

    environment {
        PROJECT_ID = "machine-494406"
        GCLOUD = "C:\\Users\\KKR\\AppData\\Local\\Google\\Cloud SDK\\google-cloud-sdk\\bin\\gcloud.cmd"
        GOOGLE_EXTERNAL_ACCOUNT_ALLOW_EXECUTABLES=1
    }

    stages {
                    

        stage('Authenticate to GCP') {
           steps {
               withCredentials([file(credentialsId: 'gcp-wif', variable: 'GOOGLE_APPLICATION_CREDENTIALS')]) {
                   bat '''
                   echo Configuring ADC for Workload Identity Federation...
                   :: Verify ADC by printing an access token
                   "%GCLOUD%" auth application-default print-access-token
                   echo Authentication setup complete.
                   '''
        }
    }
}
     

        // stage('Verify Access') {
        //     steps {
        //         bat '''
        //         echo Listing Compute Instances...
        //         "%GCLOUD%" compute instances list
        //         '''
        //     }
        // }

        stage('Terraform Init') {
            steps {
                bat '''
                echo Initializing Terraform...
                terraform init
                '''
            }
        }

        stage('Terraform Validate') {
            steps {
                bat '''
                echo Validating Terraform...
                terraform validate
                '''
            }
        }

        stage('Terraform Plan') {
            steps {
                bat '''
                echo Planning Terraform...
                terraform plan -out=tfplan
                '''
            }
        }

        stage('Terraform Apply') {
            steps {
                bat '''
                echo Applying Terraform...
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
