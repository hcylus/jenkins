FROM jenkinsci/blueocean
RUN rm -rf /var/jenkins_home/.ssh
RUN ssh-keygen -q -t rsa -N jenkins -f /var/jenkins_home/.ssh/id_rsa
RUN echo JENKINS_SLAVE_SSH_PUBKEY=`cat /var/jenkins_home/.ssh/id_rsa.pub` > /var/jenkins_home/env
