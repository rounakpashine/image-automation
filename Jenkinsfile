pipeline {
    agent any
    stages {
        stage('build') {
            steps {
                sh 'docker run -it --mount type=bind,source=/var/lib/jenkins/workspace/image-automation,target=/mnt/image.json hashicorp/packer:latest build /mnt/image.json'
            }
        }
    }
}
