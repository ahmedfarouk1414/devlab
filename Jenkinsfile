pipeline {

  environment {
    SERVER_CREDENTIALS = credentials('push')
    dockerImage = ""
    GC_KEY = push.json
    google_projectname = http-loadbalance
    image_name = nginxlb
    image-tag  = v1
  }

  agent {
         label 'slave'
        }
  
  stages {

    stage('Checkout Source') {
      steps {
        git 'https://github.com/ahmedfarouk1414/playjenkins.git'
      }
    }
    
    stage('Deploy'){
    steps{

            withCredentials([file(credentialsId: 'push', variable: 'GC_KEY')]){
              sh "cat '$GC_KEY' | docker login -u _json_key --password-stdin https://gcr.io"
              sh "gcloud auth activate-service-account --key-file='$GC_KEY'"
              sh "gcloud auth configure-docker"
              GLOUD_AUTH = sh (
                    script: 'gcloud auth print-access-token',
                    returnStdout: true
                ).trim()
              echo "Pushing image To GCR"
              sh "docker push eu.gcr.io/${http-loadbalance}/${image_name}:${image-tag}"
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
