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
   rtMaven.run pom: 'pom.xml', goals: 'clean install', buildInfo: buildInfo
   // Mark the code checkout 'stage'....
  
}