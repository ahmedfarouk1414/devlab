pipeline {

  environment {
    SERVER_CREDENTIALS = credentials('push')
    dockerImage = ""
    GC_KEY = "push.json"
    google_projectname = "http-loadbalance"
    image_name = "nginxlb"
  }

  agent {
        agent none\\\\\\\\\\\\\
        docker { image 'ahmedfarouk141414/push:latest' }
    }
  
  stages {
     agent {
                docker { image 'maven:3-alpine' }
            }
    
    stage('Checkout Source') {
      steps {
        git 'https://github.com/ahmedfarouk1414/playjenkins.git'
      }
    }
    
    stage('Deploy'){
           agent {
                docker { image 'maven:3-alpine' }
            }
    steps{
        script {
            withCredentials([file(credentialsId: 'push', variable: 'GC_KEY')]){
             // sh "cat '$GC_KEY' | docker login -u _json_key --password-stdin https://gcr.io"
              sh "gcloud auth activate-service-account --key-file='$GC_KEY'"
              sh "gcloud auth configure-docker"
              GLOUD_AUTH = sh (
                    script: 'gcloud auth print-access-token',
                    returnStdout: true
                ).trim()
              echo "Pushing image To GCR"
              sh "docker push gcr.io/${http-loadbalance}/${image_name}:v1"
          }
       }
     }
    }
    //
  //  stage('Build image') {
  //    steps{
  //      script {
   //       dockerImage = docker.build  + ":$BUILD_NUMBER"
   //     }
  //    }
  //  }
    //

 //   stage('Push image') {
 //     docker.withRegistry('https://gcr.io/http-loadbalance', 'http-loadbalance') {
  //      app.push("${env.BUILD_NUMBER}")
  //      app.push("latest")
  //    }
//}



    stage('Deploy App') {
      steps {
        script {
          kubernetesDeploy(configs: "myweb.yaml", kubeconfigId: "mykubeconfig")
        }
      }
    }
    }
  }
