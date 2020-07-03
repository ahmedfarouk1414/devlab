   
pipeline {
    agent slave
       environment {
          DOCKER_IMAGE_NAME = "ahmedfarouk141414/http"
          NEXUS_VERSION = "nexus3"
          NEXUS_PROTOCOL = "http"
          NEXUS_URL = "http://35.239.47.198:32322"   // ip add nexus server 
          NEXUS_REPOSITORY = "dockerhub"            // name repositry
         NEXUS_CREDENTIAL_ID = "nexus"             // name credienails id  in jenkins
    }
    
    stages {
        stage('Build') {
            steps {
                echo 'Running build automation'
                sh './gradlew build --no-daemon'
                archiveArtifacts artifacts: 'dist/trainSchedule.zip'
            }
        }
        stage('Build Docker Image') {
            when {
                branch 'master'
            }
            steps {
                script {
                    app = docker.build(DOCKER_IMAGE_NAME)
                             }
                }
            }
        }
        stage('Push Docker Image') {
            when {
                branch 'master'
            }
            steps {
                script {
                     withCredentials([usernamePassword(credentialsId: 'nexus', usernameVariable: 'USERNAME', passwordVariable: 'USERPASS')]) {      
                        app.push("${env.BUILD_NUMBER}")
                        app.push("latest")
                    }
                }
            }
        }
  
 
  
        stage('DeployToProduction') {
            when {
                branch 'master'
            }
            steps {
                input 'Deploy to Production?'
                milestone(1)
                kubernetesDeploy(
                    kubeconfigId: 'kubeconfig',
                    configs: 'myweb.yaml',
                    enableConfigSubstitution: true
                )
            }
        }
    }
}
