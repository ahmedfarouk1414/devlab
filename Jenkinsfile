pipeline {
    agent {
  label 'slave'
  }
        environment {
       registry = "35.188.180.98:32323/nexus"
        //DOCKER_IMAGE_NAME = "ahmedfarouk141414/orange"
        dockerImage = ""
    }
    
  stages {
      stage('Build') {
            steps {
               sh """
                   ls -al 
                   pwd
                   mvn clean package  -f Toy0Store/pom.xml 
                """
                //sh  'mvn clean package -X -f Toy0Store/pom.xml '
              }
        }
    
 
    

      stage('Build image') {
     	 steps{
      		  script {
      		    dockerImage = docker.build registry + ":$BUILD_NUMBER"
      		  }
      		}
   	 }

    
      stage('Push Image') {
     	 steps{
      	     script {
                docker.withRegistry( "" ) {
                     dockerImage.push()
          }
        }
      }
    }


  //  stage('Build Docker Image') {
          //    steps {
              //      script {
                    app = docker.build(DOCKER_IMAGE_NAME)
          //  }
      //  } 
   //  }

      //stage('Push Docker Image') {
           //  steps {
             //   script {
               //     docker.withRegistry('https://registry.hub.docker.com', 'docker_hub_login') {
                  //      app.push("${env.BUILD_NUMBER}")
                  //      app.push("latest")
                    }
               // }
          //  }
    //    }
      
       stage('DeployToProduction') {
               steps {
                input 'Deploy to Production?'
                milestone(1)
                kubernetesDeploy(
                    kubeconfigId: 'kubeconfig',
                    configs: 'manifest/spring/deployment.yaml',
                    enableConfigSubstitution: true
                )
            }
        }
                
    }
   }
