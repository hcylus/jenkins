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
