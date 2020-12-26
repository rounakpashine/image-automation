pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID = credentials('aws-access-secret-id')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key')
        }
    stages {
        stage('build') {
            steps {
                sh 'packer build image.json'
            }
        }
    }
}
