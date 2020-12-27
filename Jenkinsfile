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
            stage('packer build') {
                when { expression { return params.Terraform == 'Apply'} }       
                steps {
                    sh 'packer build image.json'
                }
            }
            stage('tf init & plan') {
                when { expression { return params.Terraform == 'Apply'} }              
                steps {
                    sh 'terraform init'
                    sh 'terraform plan'		
                }
            }                
            stage('tf apply') {
                when { expression { return params.Terraform == 'Apply'} }                       
                steps {
                    input 'Are you sure, you want to Apply this plan?'    
                    sh 'terraform apply --auto-approve'
                }                    
            }                
            stage('tf destroy') {
                when { expression { return params.Terraform == 'Destroy'} }                 
                steps {
                    input 'Are you sure, you want to Destroy this plan?'                      
                    sh 'terraform destroy --auto-approve'
                }                   
            }				
        }
    }
