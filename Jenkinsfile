pipeline {

  environment {
    registry = "myweb"
    dockerImage = ""
  }

  agent any

  stages {

    stage('Checkout Source') {
      steps {
        git 'https://github.com/ahmedfarouk1414/playjenkins.git'
      }
    }


    
stage('Build image') {
  app = docker.build("http-loadbalance/javabuild")
}
stage('Push image') {
  docker.withRegistry('https://gcr.io', 'gcr:[playjenkins]') {
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
