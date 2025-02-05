pipeline {
    agent any

    environment {
        NODEJS_VERSION = '18'  // Ensure compatible Node.js version
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/Susmita-code007/json-server'
            }
        }

        stage('Setup Node.js') {
            steps {
                script {
                    def nodeHome = tool name: "NodeJS-${NODEJS_VERSION}", type: "jenkins.plugins.nodejs.tools.NodeJSInstallation"
                    env.PATH = "${nodeHome}/bin:${env.PATH}"
                }
            }
        }

        stage('Install Dependencies') {
            steps {
                sh 'npm install'
            }
        }

        stage('Run Tests') {
            steps {
                sh 'npm test'
            }
        }
    }

    post {
        success {
            echo "✅ Build and deployment successful!"
        }
        failure {
            echo "❌ Build failed!"
        }
    }
}
