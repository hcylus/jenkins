通过ssh方式构建master-slave
镜像基于官方jenkinsci

## master

创建jenkins目录用于数据本地持久化(挂载到master镜像/var/jenkins_home目录)

`mkdir $HOME/jenkins`

## slave

创建slave目录用于数据本地持久化(挂载到slave镜像/home/jenkins目录)

`mkdir $HOME/jenkins/slave`

## docker-compose构建

进入jenkins/master-slave-ssh目录执行

`docker-compose up -d`


docker cp masterslavessh_jenkinsci-master_1:/tmp/ssh/id_rsa.pub authorized_keys

docker cp authorized_keys masterslavessh_jenkinsci-slave_1:/home/jenkins/.ssh/authorized_keys

docker exec masterslavessh_jenkinsci-slave_1 chown jenkins.jenkins /home/jenkins/.ssh/authorized_keys

docker exec masterslavessh_jenkinsci-slave_1 chmod 700 /home/jenkins/.ssh/authorized_keys

docker inspect -f '{{.NetworkSettings.Networks.masterslavessh_default.IPAddress}}' masterslavessh_jenkinsci-slave_1
