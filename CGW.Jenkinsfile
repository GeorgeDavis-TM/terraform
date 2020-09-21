pipeline {
    agent { 
        label 'terraform' 
    }
    stages {
        stage('Pre-cleanup') {
            steps {
                sh '''                                
                    terraform version
                '''
            }            
        }
        stage('Prep Terraform') {
            steps {
                sh '''                
                    terraform init
                '''
            }            
        }
    }
}
