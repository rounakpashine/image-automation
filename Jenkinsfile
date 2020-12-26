pipeline {
    agent any
    stages {
        stage('build') {
            steps {
                sh 'docker run -it --mount type=bind,source=image.json,target=/mnt/image.json hashicorp/packer:latest build /mnt/image.json'
            }
        }
    }
}
