pipeline {
    agent { label 'serverB' }

    environment {
        DOCKER_IMAGE_NAME = 'ankitha702/devopshubapp'
        DOCKER_CREDENTIALS_ID = 'dockerhub'
        CONTAINER_NAME = 'devopshubapp-container'
        CONTAINER_PORT = '8080'
    }

    stages {
        stage('Code Checkout') {
            steps {
                git url: 'https://github.com/ankitha93/devopshubapp-repo.git', branch: 'main'
            }
        }

        stage('Build with Maven') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Docker Image Creation') {
            steps {
                echo 'Docker image files are ready'
            }
        }

        stage('Docker Build') {
            steps {
                script {
                    dockerImage = docker.build("${DOCKER_IMAGE_NAME}:${env.BUILD_NUMBER}")
                }
            }
        }

        stage('Docker Publish') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', "${DOCKER_CREDENTIALS_ID}") {
                        dockerImage.push()
                        dockerImage.push('latest')
                    }
                }
            }
        }

        stage('Run Container') {
            steps {
                script {
                    sh """
                        docker stop ${CONTAINER_NAME} || true
                        docker rm ${CONTAINER_NAME} || true
                        docker run -d --name ${CONTAINER_NAME} -p ${CONTAINER_PORT}:8080 ${DOCKER_IMAGE_NAME}:${env.BUILD_NUMBER}
                    """
                }
            }
        }
    }

    post {
        success {
            echo "Build, publish, and container run successful."
        }
        failure {
            echo "Build failed!"
        }
    }
}
