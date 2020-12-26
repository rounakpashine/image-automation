pipeline {
    agent any
    stages {
        stage('build') {
            steps {
                sh 'sudo docker run hashicorp/packer:light build image.json'
            }
        }
    }
}
