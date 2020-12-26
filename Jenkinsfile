pipeline {
    agent any
    stages {
        stage('build') {
            steps {
                sh 'sudo docker container run -it hashicorp/packer build image.json'
            }
        }
    }
}
