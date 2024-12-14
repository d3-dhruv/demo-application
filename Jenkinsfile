pipeline {
    agent any

    tools{
        jdk 'jdk17'
        maven 'maven3'
    }

    stages {
        stage('Git Check Out') {
            steps {
                git branch: 'main', url: 'https://github.com/Srinu-rj/spring-food-app.git'
            }
        }
        stage('Compile') {
            steps {
                sh "mvn compile"
            }
        }
//         stage('Build and Test') {
//             steps {
//                 sh 'mvn clean test'
//             }
//         }
        stage('Test') {
            steps {
                  sh "mvn test"
            }
        }
    }
}