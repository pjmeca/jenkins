#!groovy

pipeline {
    agent any

    environment {
        BASE_IMAGE = "jenkins/jenkins:latest"
        CUSTOM_IMAGE = "pjmeca/jenkins"
    }

    stages {
        stage('Check base image update') {
            steps {
                script {
                    sh "docker pull ${BASE_IMAGE}"

                    def digest = sh(
                        script: "docker inspect --format='{{index .RepoDigests 0}}' ${BASE_IMAGE}",
                        returnStdout: true
                    ).trim()

                    def lastDigestFile = '.last_base_digest'

                    if (fileExists(lastDigestFile)) {
                        def previous = readFile(lastDigestFile).trim()
                        if (previous == digest) {
                            echo "Jenkins base image is already up-to-date. Skipping build."
                            currentBuild.result = 'SUCCESS'
                            return
                        }
                    }

                    writeFile file: lastDigestFile, text: digest
                }
            }
        }

        stage('Build image') {
            steps {
                script {
                    env.TS = sh(
                        script: "date +%Y%m%d-%H%M%S",
                        returnStdout: true
                    ).trim()

                    sh """
                        docker build -t ${CUSTOM_IMAGE}:${ts} -t ${CUSTOM_IMAGE}:latest .
                    """
                }
            }
        }

        stage('Push image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials',
                                                  usernameVariable: 'DOCKER_USER',
                                                  passwordVariable: 'DOCKER_PASS')]) {
                    sh """
                        echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                        docker push ${CUSTOM_IMAGE}:${env.TS}
                        docker push ${CUSTOM_IMAGE}:latest
                    """
                }
            }
        }
    }
}
