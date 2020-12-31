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
            stage('image bake') {
                when { expression { return params.Terraform == 'Apply'} }       
                steps {
                    sh 'packer inspect packer/image.json'
                    sh 'packer validate packer/image.json'
                    sh 'packer build packer/image.json'                        
                }
            }
            stage('infrastructure assess & plan') {
                when { expression { return params.Terraform == 'Apply'} }              
                steps {
                    sh 'terraform -chdir=terraform init'
                    sh 'terraform -chdir=terraform validate'
                    sh 'sudo docker container run -t --rm -v $(pwd)/terraform:/data wata727/tflint'
                    sh 'sudo docker container run -t --rm -v "$(pwd)/terraform:/src" liamg/tfsec /src'
                    sh 'echo "sudo docker container run -t --rm -v "$(pwd)/terraform:/tf" bridgecrew/checkov -d /tf"'
                    sh 'terraform -chdir=terraform plan'                         
                }
            }               
            stage('infrastructure deploy') {
                when { expression { return params.Terraform == 'Apply'} }                       
                steps {
                    input 'Are you sure, you want to Apply this plan?'                        
                    sh 'terraform -chdir=terraform apply --auto-approve'
                }                    
            }                
            stage('infrastructure destroy') {
                when { expression { return params.Terraform == 'Destroy'} }                 
                steps {
                    input 'Are you sure, you want to Destroy this plan?'                      
                    sh 'terraform -chdir=terraform destroy --auto-approve'
                }                   
            }				
        }
    }
