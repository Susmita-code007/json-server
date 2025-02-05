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
    
 }
}

