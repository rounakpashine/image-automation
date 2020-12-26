pipeline {
    agent any
    stages {
        stage('build') {
            steps {
                sh 'docker run -i --mount type=bind,source=/var/lib/jenkins/workspace/image-automation,target=/mnt/image.json hashicorp/packer:latest build /mnt/image.json'
            }
        }
    }
}
