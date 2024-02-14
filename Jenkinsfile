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
    
        stage('node-server-check') {
        agent { 
            docker 'node:20.11.0-alpine3.19'
        }
            steps {
                sh 'node --version'
             
            }
        }
        stage('Composer Dependicies Install') {
        agent {
          docker 'composer:latest'
        }
          steps {
            sh 'composer install'
          }
        }
    }
}
