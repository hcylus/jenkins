FROM jenkinsci/blueocean
ENV HOME /var/jenkins_home
WORKDIR $HOME
RUN rm -rf /tmp/ssh
RUN mkdir -p /tmp/ssh
RUN ssh-keygen -q -t rsa -N jenkins -f /tmp/ssh/id_rsa
#RUN echo JENKINS_SLAVE_SSH_PUBKEY=`cat /tmp/ssh/id_rsa.pub` > /tmp/ssh/env
