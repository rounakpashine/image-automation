pipeline {
    agent any
    stages {
        stage('build') {
            steps {
                sh 'docker run -i -t hashicorp/packer:light build image.json'
            }
        }
    }
}
