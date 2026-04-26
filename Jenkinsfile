pipeline {
    agent any

    environment {
        PROJECT_ID = "machine-494406"
        GCLOUD = "C:\\Users\\KKR\\AppData\\Local\\Google\\Cloud SDK\\google-cloud-sdk\\bin\\gcloud.cmd"
        TF_IN_AUTOMATION = "true"
    }

    stages {

        stage('Authenticate and Verify GCP') {
            steps {
                withCredentials([file(credentialsId: 'gcp-wif', variable: 'WIF_CRED_FILE')]) {
                    withEnv([
                        "GOOGLE_APPLICATION_CREDENTIALS=${WIF_CRED_FILE}",
                        "GOOGLE_EXTERNAL_ACCOUNT_ALLOW_EXECUTABLES=1"
                    ]) {
                        bat '''
                        echo ===== CHECK FILE =====
                        if not exist "%GOOGLE_APPLICATION_CREDENTIALS%" (
                          echo Credential file not found
                          exit /b 1
                        )

                        echo ===== GCLOUD VERSION =====
                        call "%GCLOUD%" version

                        echo ===== SET PROJECT =====
                        call "%GCLOUD%" config set project %PROJECT_ID%

                        echo ===== TEST ACCESS TOKEN =====
                        call "%GCLOUD%" auth application-default print-access-token
                        if errorlevel 1 exit /b 1

                        echo ===== LIST INSTANCES =====
                        call "%GCLOUD%" compute instances list
                        '''
                    }
                }
            }
        }

        stage('Terraform Init') {
            steps {
                withCredentials([file(credentialsId: 'gcp-wif', variable: 'WIF_CRED_FILE')]) {
                    withEnv([
                        "GOOGLE_APPLICATION_CREDENTIALS=${WIF_CRED_FILE}",
                        "GOOGLE_EXTERNAL_ACCOUNT_ALLOW_EXECUTABLES=1"
                    ]) {
                        bat '''
                        echo ===== TERRAFORM INIT =====
                        terraform init -upgrade
                        '''
                    }
                }
            }
        }

        stage('Terraform Validate') {
            steps {
                withCredentials([file(credentialsId: 'gcp-wif', variable: 'WIF_CRED_FILE')]) {
                    withEnv([
                        "GOOGLE_APPLICATION_CREDENTIALS=${WIF_CRED_FILE}",
                        "GOOGLE_EXTERNAL_ACCOUNT_ALLOW_EXECUTABLES=1"
                    ]) {
                        bat '''
                        echo ===== TERRAFORM VALIDATE =====
                        terraform validate
                        '''
                    }
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                withCredentials([file(credentialsId: 'gcp-wif', variable: 'WIF_CRED_FILE')]) {
                    withEnv([
                        "GOOGLE_APPLICATION_CREDENTIALS=${WIF_CRED_FILE}",
                        "GOOGLE_EXTERNAL_ACCOUNT_ALLOW_EXECUTABLES=1"
                    ]) {
                        bat '''
                        echo ===== TERRAFORM PLAN =====
                        terraform plan -out=tfplan
                        '''
                    }
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                input message: 'Apply Terraform plan?', ok: 'Apply'
                withCredentials([file(credentialsId: 'gcp-wif', variable: 'WIF_CRED_FILE')]) {
                    withEnv([
                        "GOOGLE_APPLICATION_CREDENTIALS=${WIF_CRED_FILE}",
                        "GOOGLE_EXTERNAL_ACCOUNT_ALLOW_EXECUTABLES=1"
                    ]) {
                        bat '''
                        echo ===== TERRAFORM APPLY =====
                        terraform apply -auto-approve tfplan
                        '''
                    }
                }
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
