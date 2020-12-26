pipeline {
    agent any
    stages {
        stage('build') {
            steps {
                sh 'sudo packer build image.json'
            }
        }
    }
}
