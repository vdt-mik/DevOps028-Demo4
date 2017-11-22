FROM jenkins/jenkins:lts

USER jenkins

COPY config/*.xml ${JENKINS_HOME}/
COPY config/plugins.txt ${JENKINS_HOME}/plugins.txt
COPY config/*.groovy /usr/share/jenkins/ref/init.groovy.d/
RUN /usr/local/bin/install-plugins.sh < ${JENKINS_HOME}/plugins.txt