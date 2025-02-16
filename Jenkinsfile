pipeline {
   agent any
   stages {
      stage('Install Dependencies') {
            steps {
                sh 'npm install'
            }
        }
      stage('Build') {
            steps {
                sh 'npm run build --if-present'
            }
      }
      stage('Test'){
             steps {
                sh 'npm test'
             }
       }
       stage('Check Dependencies') {
            steps {
                echo "🔍 Checking for missing dependencies..."
                catchError(buildResult: 'UNSTABLE', stageResult: 'FAILURE') {
                    sh './check_packages.sh vulnerable_packages.json'
                }
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

