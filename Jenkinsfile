pipeline {
    agent any
    stages {
        stage('build') {
            steps {
                sh 'sudo docker container run -it hashicorp/packer:light build image.json'
            }
        }
    }
}
