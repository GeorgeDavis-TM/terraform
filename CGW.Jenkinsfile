pipeline {
    agent master
    stages {
        stage('Pre-cleanup') {
            sh '''                                
                terraform version
            '''
        }
        stage('Prep Terraform') {
            sh '''                
                terraform init
            '''
        }
    }
}
