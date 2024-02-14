pipeline {
    agent any
    stages {
        stage('Build') {
            environment {
                PR_URL = sh (
                script: 'echo $WORKSPACE',
                returnStdout: true
                ).trim()
            }
            steps {
                sh 'echo "$PR_URL"'
            }
        }
        stage('Installing php') {
        agent {
          docker 'php:7.3'
        }
          steps {
            sh 'php  -v'
            sh 'curl  -sS https://getcomposer.org/installer | php  -- --install-dir=/usr/bin --file-name=composer'
            echo ' Installing Dependicies '
            sh ' sudo composer install'
          }
        }
    }
}
