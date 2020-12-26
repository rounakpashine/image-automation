pipeline {
    agent any
    stages {
        stage('build') {
            steps {
                sh 'docker run hashicorp/packer:light build image.json'
            }
        }
    }
}
