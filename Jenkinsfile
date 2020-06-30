pipeline {

  environment {
    SERVER_CREDENTIALS = credentials('push')
    dockerImage = ""
  }

  agent default

  stages {

    stage('Checkout Source') {
      steps {
        git 'https://github.com/ahmedfarouk1414/playjenkins.git'
      }
    }

    stage('Build image') {
      steps{
        script {
          dockerImage = docker.build registry + ":$BUILD_NUMBER"
        }
      }
    }

    stage('Push image') {
      docker.withRegistry('https://gcr.io/http-loadbalance', 'http-loadbalance') {
        app.push("${env.BUILD_NUMBER}")
        app.push("latest")
      }
}



    stage('Deploy App') {
      steps {
        script {
          kubernetesDeploy(configs: "myweb.yaml", kubeconfigId: "mykubeconfig")
        }
      }
    }

  }

}


