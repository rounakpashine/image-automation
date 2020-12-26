pipeline {
    agent any
    stages {
        stage('build') {
            steps {
                sh 'packer build image.json'
            }
        }
    }
}
