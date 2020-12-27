pipeline {
        agent any
        environment {
            AWS_ACCESS_KEY_ID = credentials('aws-access-secret-id')
            AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key')
            }
        parameters {
             choice(name: 'Terraform', choices: ['Apply', 'Destroy'], description: 'Apply for tf apply, and Destroy for tf destroy')
        }    

        stages {
            stage('packer build') {
                when { expression { return params.Terraform == 'Apply'} }       
                steps {
                    sh 'echo "no more packer"'
                }
            }
            stage('tf init') {
                when { expression { return params.Terraform == 'Apply'} }              
                steps {
                    sh 'terraform init'	
                }
            }
            stage('tf plan') {
                when { expression { return params.Terraform == 'Apply'} }              
                steps {
                    sh 'terraform plan'		
                }
            }
            stage('tf sec') {
                when { expression { return params.Terraform == 'Apply'} }              
                steps {
                    sh 'git clone https://github.com/Homebrew/brew ~/.linuxbrew/Homebrew'
                    sh 'mkdir ~/.linuxbrew/bin'
                    sh 'ln -s ../Homebrew/bin/brew ~/.linuxbrew/bin'
                    sh 'eval $(~/.linuxbrew/bin/brew shellenv)'
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
