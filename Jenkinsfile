pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID = credentials('aws-access-secret-id')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key')
        }
    parameters {
        booleanParam(name: "RELEASE", defaultValue: true)
    }    

    stages {
        stage('build image') {
            when { expression { params.RELEASE } }            
            steps {
                sh 'packer build image.json'
            }
        }
        stage('Infrastructure plan') {
            when { expression { params.RELEASE } }            
            steps {
                sh 'terraform init'
                sh 'terraform plan'		
            }
        }
        stage('Infrastructure deploy') {
            when { expression { params.RELEASE } }            
            steps {
                sh 'terraform apply --auto-approve'
            }
        }    
        stage('Infrastructure destroy') {
            when { expression { !params.RELEASE } }            
            steps {
                sh 'terraform destroy --auto-approve'
            }            
        }				
    }
}
