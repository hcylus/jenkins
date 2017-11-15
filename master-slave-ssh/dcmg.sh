#!/bin/bash

function initdc() {
	echo "--- set ssh master -->> slave key ---"
	echo

	[ -f authorized_keys ] && rm -rf authorized_keys

	docker cp masterslavessh_jenkinsci-master_1:/tmp/.ssh/id_rsa.pub authorized_keys

	docker cp authorized_keys masterslavessh_jenkinsci-slave_1:/home/jenkins/.ssh/authorized_keys

	docker exec masterslavessh_jenkinsci-slave_1 chown jenkins.jenkins /home/jenkins/.ssh/authorized_keys

	docker exec masterslavessh_jenkinsci-slave_1 chmod 700 /home/jenkins/.ssh/authorized_keys

	echo "--- jenkins slave ip ---"
	
	docker inspect -f '{{.NetworkSettings.Networks.masterslavessh_default.IPAddress}}' masterslavessh_jenkinsci-slave_1

	echo
	echo "--- jenkins master key ---"
	echo

	docker exec masterslavessh_jenkinsci-master_1 cat /tmp/.ssh/id_rsa

	echo
	echo "--- jenkins init password ---"
	
	docker exec masterslavessh_jenkinsci-master_1 cat /var/jenkins_home/secrets/initialAdminPassword
}	

case $1 in
	init)
	docker-compose up -d --build;
	initdc;;
	start)
	docker-compose start;
	initdc;;
	stop)
	docker-compose stop;;
	restart)
	docker-compose restart;
	initdc;;
	status)
	docker-compose ps;;
	down)
	docker-compose down;;
	*)
	echo "Usage: `basename $0` init|start|stop|restart|status|down";;
esac	

