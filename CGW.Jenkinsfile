pipeline {
    agent { 
        label 'terraform' 
    }
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
