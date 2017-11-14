通过ssh方式构建master-slave
镜像基于官方jenkinsci

## 设置说明

master-slave时区统一设置为东八区（+0800）

master数据存放于$HOME/jenkins

slave数据存放于$HOME/jenkins/slave

## docker-compose构建

进入jenkins/master-slave-ssh目录执行

`docker-compose up -d --build`

从master容器复制公钥到本地

docker cp masterslavessh_jenkinsci-master_1:/tmp/.ssh/id_rsa.pub authorized_keys

用master公钥覆盖slave启动时导入的key（启动时导入的是临时的key，此操作目的是解决jenkinsci/ssh-slave启动时传参问题，以保证master和slave使用的是同一对密钥）

docker cp authorized_keys masterslavessh_jenkinsci-slave_1:/home/jenkins/.ssh/authorized_keys

docker exec masterslavessh_jenkinsci-slave_1 chown jenkins.jenkins /home/jenkins/.ssh/authorized_keys

docker exec masterslavessh_jenkinsci-slave_1 chmod 700 /home/jenkins/.ssh/authorized_keys

使用默认密码（保持在/var/jenkins_home/secrets/initialAdminPassword文件）访问[jenkins](http://127.0.0.1:8080/)

## 添加节点

安装SSH Slaves plugin插件

获取slave节点ip（用户为jenkins）

docker inspect -f '{{.NetworkSettings.Networks.masterslavessh_default.IPAddress}}' masterslavessh_jenkinsci-slave_1

获取master私钥

docker exec masterslavessh_jenkinsci-master_1 cat /tmp/.ssh/id_rsa
