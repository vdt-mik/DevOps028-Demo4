<?xml version='1.0' encoding='UTF-8'?>
<flow-definition plugin="workflow-job@2.15">
  <actions/>
  <description>DevOps028-Demo4</description>
  <keepDependencies>false</keepDependencies>
  <properties>
    <org.datadog.jenkins.plugins.datadog.DatadogJobProperty plugin="datadog@0.6.1">
      <tagProperties></tagProperties>
      <tagFile></tagFile>
      <emitOnCheckout>false</emitOnCheckout>
    </org.datadog.jenkins.plugins.datadog.DatadogJobProperty>
    <com.coravy.hudson.plugins.github.GithubProjectProperty plugin="github@1.28.1">
      <projectUrl>https://github.com/vdt-mik/DevOps028-Demo4/</projectUrl>
      <displayName>DevOps028-Demo4</displayName>
    </com.coravy.hudson.plugins.github.GithubProjectProperty>
    <org.jenkinsci.plugins.workflow.job.properties.PipelineTriggersJobProperty>
      <triggers/>
    </org.jenkinsci.plugins.workflow.job.properties.PipelineTriggersJobProperty>
  </properties>
  <definition class="org.jenkinsci.plugins.workflow.cps.CpsScmFlowDefinition" plugin="workflow-cps@2.41">
    <scm class="hudson.plugins.git.GitSCM" plugin="git@3.6.4">
      <configVersion>2</configVersion>
      <userRemoteConfigs>
        <hudson.plugins.git.UserRemoteConfig>
          <url>https://github.com/vdt-mik/DevOps028-Demo4</url>
          <credentialsId>aee943b5-5844-4aa0-8ad8-3e2eafdc1ce5</credentialsId>
        </hudson.plugins.git.UserRemoteConfig>
      </userRemoteConfigs>
      <branches>
        <hudson.plugins.git.BranchSpec>
          <name>*/master</name>
        </hudson.plugins.git.BranchSpec>
      </branches>
      <doGenerateSubmoduleConfigurations>false</doGenerateSubmoduleConfigurations>
      <submoduleCfg class="list"/>
      <extensions/>
    </scm>
    <scriptPath>Jenkinsfile</scriptPath>
    <lightweight>true</lightweight>
  </definition>
  <triggers/>
  <disabled>false</disabled>
</flow-definition>