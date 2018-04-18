node {
   //def artServer = Artifactory.newServer url: SERVER_URL, credentialsId: CREDENTIALS
  def artServer = Artifactory.server('artiha-demo')
  artServer.credentialsId='art-docker-ci'
  def buildInfo = Artifactory.newBuildInfo()
  stage 'Checkout MAVEN'
  git url: 'https://github.com/jinriyang/wchat-demo.git', credentialsId: 'jry'
  
  stage 'Build Maven'
  def rtMaven = Artifactory.newMavenBuild()
  
  rtMaven.resolver server: artServer, releaseRepo: 'libs-release', snapshotRepo: 'libs-snapshot'
  rtMaven.deployer server: artServer, releaseRepo: 'libs-snapshot-local', snapshotRepo: 'libs-snapshot-local'
  rtMaven.tool = 'maven'
   rtMaven.run pom: 'pom.xml', goals: 'clean install -Dmaven.test.skip=true', buildInfo: buildInfo
   // Mark the code checkout 'stage'....
   stage('Checkout Docker') {
   // Get some code from a GitHub repository
   git url: 'https://github.com/jinriyang/rancher-demo.git' ,  credentialsId: 'jry'
   }
  buildInfo.env.capture = true
withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'admin',
usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD']]) {
def uname=env.USERNAME
def pw=env.PASSWORD
artServer.username=uname
artServer.password=pw
 sh 'echo credentials applied'
 def curlstr="curl -u"+uname+':'+pw+" 'http://demo.jfrogchina.com/artifactory/"
dir('docker-app') {
   stage('Resolve') {
        def downloadSpec = """{
 "files": [
  {
   "pattern": "libs-snapshot-local/com/example/wchat/1.0.0/wchat-1.0.0.jar",
   "target": "wchat-1.0.0.jar",
   "flat":"true"
  }
  ]
}"""
    println(downloadSpec)
    artServer.download(downloadSpec, buildInfo)
   }
   stage('Build and Deploy') {
        def tagName='docker-release-local.demo.jfrogchina.com/rancher-demo:'+env.BUILD_NUMBER
        docker.build(tagName)
        def artDocker= Artifactory.docker(uname, pw)
        artDocker.push(tagName, 'docker-release-local', buildInfo)
        artServer.publishBuildInfo(buildInfo)
   }
}
}
}
