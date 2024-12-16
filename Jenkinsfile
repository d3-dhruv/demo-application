pipeline {
    agent any
    tools {
        maven 'maven3'
        jdk 'jdk17'
    }
    environment{
        SCANNER_HOHE= tool 'sonar-scanner'
        DOCKER_USERNAME = 'imclouduser'
        DOCKER_PASSWORD = credentials('docker-cred') 
    }
    stages {
        stage('Git Checkout') {
            steps {
                git branch: 'main' , credentialsId: 'git-cred' , url: 'https://github.com/d3-dhruv/demo-application.git'

            }
        }

        stage('Maven Compile') {
            steps {
                echo 'Maven COmpile Started'
                sh 'mvn compile'
                echo 'Maven COmpile Finished'
            }
        }
        stage('Maven Test') {
            steps {
                echo 'Maven Test Started'
                sh 'mvn test'
                echo 'Maven Test Finished'
            }
        }
        stage('File System Scan') {
            steps {
                echo 'Trivy Scan Started'
                sh 'trivy fs --format table --output trivy-fs-output.html .'
                echo 'Trivy Scan Finished'
            }
        }
        stage('SonarQube-Analysis') { 
            steps { 
                script { 
                 echo "sonarqube code analysis"
                 withSonarQubeEnv(credentialsId: 'sonartoken') {
                     sh ''' $SCANNER_HOHE/bin/sonar-scanner -Dsonar.projectName=springfood  -Dsonar.projectKey=springfood \
                     -Dsonar.java.binaries=. '''
                 echo "End of sonarqube code analysis"    

                   }
                }  
            }     
        }
         stage('Quality Gate') { 
            steps { 
                script { 
                  echo "sonarqube Quality Gate"    
                  waitForQualityGate abortPipeline: false, credentialsId: 'sonartoken'
                  echo "End Sonarqube Quality Gate"    
                  
                } 
            } 
        }
        
        stage('Mvn Build') { 
            steps { 
              sh "mvn package"
            } 
        }
          stage("Upload jar file to Nexus"){
           steps{
               script{
                   echo "--> Nexus started <--"
                   
                   nexusArtifactUploader artifacts:
                   [
                     [
                       artifactId: 'demo-application',
                       classifier: '',
                       file: 'target/demo-application-0.0.1-SNAPSHOT.jar',
                       type: 'jar'
                     
                       ]

                    ],
                    credentialsId: 'nexus-credential',
                    groupId: 'com.example',
                    nexusUrl: '127.0.0.1:8081',
                    nexusVersion: 'nexus3',
                    protocol: 'http',
                    repository: 'spring-maven',
                    version: '0.0.1'
               }
           }    
        }
        
        stage('Docker Images and TAG') { 
            steps { 
                script { 
                 echo "Docker Images"        
                    sh 'docker build -t demo-application:latest .'
                    echo "End of Docker Images"
                } 
            } 
        }
        stage('Docker image scan') {
            steps{
                sh 'trivy image --format table --scanners vuln -o trivy-image-report.html demo-application:latest'
            }
        }
        stage('Push Docker Image'){
            steps {
                script {
                 
                    sh "docker image tag demo-application:latest imclouduser/demo-application:latest"
                    sh "docker push imclouduser/demo-application:latest"
                }
            }
        }
        stage ('Docker build'){
            steps {
                script{
                    dockerImage = docker.build registry
                }
            }
        }
        stage ('Docker push'){
            steps {
                script{
                    sh 'aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin id.dkr.ecr.us-east-1.amazonaws.com'
                    sh 'docker build -t demo-application .'
                    sh 'docker tag demo-application:latest id.dkr.ecr.us-east-1.amazonaws.com/myrepo:latest'
                    sh 'docker push id.dkr.ecr.us-east-1.amazonaws.com/myrepo:latest'
                }
            }
        }
        stage('Deploy To Kubernetes') {
        steps {
         withKubeConfig(caCertificate: '', clusterName: 'my-eks2', contextName: '', credentialsId: 'k8-cred', namespace: 'default', restrictKubeConfigAccess: false, serverUrl: 'https://id.....gr7.us-east-1.eks.amazonaws.com')
         {
            sh "kubectl apply -f eks-deploy-k8s.yaml"
            }
        }
    }
         
    }   
}