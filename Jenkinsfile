pipeline {
    agent { label 'serverB' }

    environment {
        // Set Docker Hub credentials and image name
        DOCKER_IMAGE_NAME = 'ankitha702/myapp'
        DOCKER_CREDENTIALS_ID = 'dockerhub' // Jenkins credential ID for Docker Hub
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
                    // Just preparing Dockerfile, context, or any required pre-steps
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
                        dockerImage.push('latest') // Optional: tag as latest
                    }
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
