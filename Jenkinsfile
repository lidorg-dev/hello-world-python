pipeline {
  agent any
  stages {
    stage('checkout-code') {
      steps {
        git(url: 'https://github.com/lidorg-dev/hello-world-python.git', branch: 'master', changelog: true, poll: true)
      }
    }

  }
}