podTemplate(label: 'slave', containers: [
  containerTemplate(image: 'docker', name: 'docker', privileged: true,  workingDir: '/home/jenkins', command: 'cat', ttyEnabled: true),
  containerTemplate(image: 'maven', name: 'maven', privileged: true,  workingDir: '/home/jenkins', command: 'cat', ttyEnabled: true),
  containerTemplate(image: 'tutum/curl', name: 'curl', privileged: true,  workingDir: '/home/jenkins', command: 'cat', ttyEnabled: true)
  ],
  volumes: [
    hostPathVolume(hostPath: '/var/run/docker.sock', mountPath: '/var/run/docker.sock')
  ]) {
      node ('slave'){
          stage('Checkout') {
            git url: 'https://github.com/vdt-mik/DevOps028-Demo4'
          }
          container ('maven') {
            stage('Build package') {
              try {
              sh 'mvn clean test'
              sh 'mvn clean package'
              } catch (e) {
                currentBuild.result = 'FAILURE'
                }    
            }
            stage ('Post') {
              if (currentBuild.result == null || currentBuild.result == 'SUCCESS') {
                archiveArtifacts artifacts: 'target/*.jar', onlyIfSuccessful: true  
                sh 'cp target/Samsara-*.jar .'
              }
            }
          }
          container ('docker') {
            stage('Build db docker image') {
              def dbImage = docker.build("127.0.0.1:5000/db:latest","--build-arg DB_NAME=${DB_NAME} --build-arg DB_USER=${DB_USER} --build-arg DB_PASS=${DB_PASS} -f app/db/Dockerfile .")
              sh 'docker push "127.0.0.1:5000/db:latest"'
            }
          }
          container ('curl') {
            stage('Configure kubectl tool') {
              sh "curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.8.0/bin/linux/amd64/kubectl"
              sh "chmod +x ./kubectl && mv ./kubectl /usr/local/bin/kubectl && mkdir -p ~/.kube"
              sh "cp app/info.yaml ~/.kube/config && kubectl cluster-info"
            }
            stage('Deploy db in k8s'){
              sh 'kubectl apply -f ./app/db/k8s/deployment.yaml'
              sh 'kubectl rollout status deployment/dbdeployment && sleep 120'
              def DB_HOST = sh(
                  script: "kubectl describe services dbservice | grep 'LoadBalancer Ingress:' | cut -d':' -f2 | tr -d ' '",
                  returnStdout: true
                  ).trim()
            }      
          }
          container ('docker') {
            stage('Build app docker image') {
              ART_NAME = sh(
              script: "ls ${WORKSPACE}/target | grep jar | grep -v original",
              returnStdout: true
              ).trim()
              def samsaraImage = docker.build("127.0.0.1:5000/samsara:latest","--build-arg DB_HOST=${DB_HOST} --build-arg DB_PORT=${DB_PORT} --build-arg DB_NAME=${DB_NAME} --build-arg DB_USER=${DB_USER} --build-arg DB_PASS=${DB_PASS} --build-arg ART_NAME=${ART_NAME} -f app/app/Dockerfile .")
            }
            stage('Push app docker image') {
              sh 'docker push 127.0.0.1:5000/samsara:latest'
            }
          }
          container ('curl') {
            stage('Configure kubectl tool') {
              sh "curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.8.0/bin/linux/amd64/kubectl"
              sh "chmod +x ./kubectl && mv ./kubectl /usr/local/bin/kubectl && mkdir -p ~/.kube"
              sh "cp app/info.yaml ~/.kube/config && kubectl cluster-info"
            }
            stage('Deploy db in k8s'){
              sh 'kubectl apply -f ./app/app/k8s/deployment.yaml'
              sh 'kubectl rollout status deployment/appdeployment && sleep 120'
            }      
            stage('Check APP') {
              timeout(time: 2, unit: 'MINUTES') {
                APP_URI = sh(
                script: "kubectl describe services appservice | grep 'LoadBalancer Ingress:' | cut -d':' -f2 | tr -d ' '",
                returnStdout: true
                ).trim()
                waitUntil {
                  try { 
                    def response = httpRequest "http://$APP_URI:9000/login" 
                    println("Status: "+response.status) 
                    println("Content: "+response.content)
                    return true
                  } catch (Exception e) {
                      return false
                    }
                }
              }
            }      
          }
        }
      }