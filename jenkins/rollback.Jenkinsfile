pipeline {
    agent any
    stages {
        stage('Rollback') {
            steps {
                sh "kubectl rollout undo deployment account-service"
            }
        }
    }
}
