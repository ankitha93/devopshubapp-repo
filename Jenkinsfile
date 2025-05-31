pipeline {
    agent { label 'serverB' }

    environment {
        DOCKER_IMAGE_NAME = 'ankitha702/devopshubapp'
        DOCKER_CREDENTIALS_ID = 'dockerhub'
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
                script {
                    echo 'Docker image files are ready'
                }
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
                    sh '''
                        docker stop devopshubapp-container || true
                        docker rm devopshubapp-container || true
                        docker run -d --name devopshubapp-container -p 8080:8080 ankitha702/devopshubapp:${BUILD_NUMBER}
                    '''
                }
            }
        }
    }

    post {
        success {
            echo "Build and Docker image published successfully."
        }
        failure {
            echo "Build failed!"
        }
    }
}
