pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID = credentials('aws-access-secret-id')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key')
        }
    parameters {
         choice(name: 'Terraform', choices: ['Apply', 'Destroy'], description: 'Choose Apply for Infrastructure deploy and Destroy for Infrastructure destroy')
    }    

    stages {
        stage('build image') {
            when { expression {params.Terraform} = 'Apply'}         
            steps {
                sh 'packer build image.json'
            }
        }
        stage('Infrastructure plan') {
            when ${params.Terraform} = 'Apply'                
            steps {
                sh 'terraform init'
                sh 'terraform plan'		
            }
        }
        stage('Infrastructure deploy') {
            when ${params.Terraform} = 'Apply'               
            steps {
                sh 'terraform apply --auto-approve'
            }
        }    
        stage('Infrastructure destroy') {
            when ${params.Terraform} = 'Destroy'               
            steps {
                sh 'terraform destroy --auto-approve'
            }            
        }				
    }
}
