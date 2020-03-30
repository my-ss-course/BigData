#!/bin/bash

echo start containers

echo start hadoop-node1 container ...
docker run -itd --restart=always --net hadoop --ip 172.18.0.2 --privileged -p 18032:8032 -p 28080:18080 -p 29888:19888 -p 17077:7077 -p 51070:50070 -p 18888:8888 -p 19000:9000 -p 11100:11000 -p 51030:50030 -p 18050:8050 -p 18081:8081 -p 18900:8900 --name hadoop-node1 --hostname hadoop-node1  --add-host hadoop-node2:172.18.0.3 --add-host hadoop-node3:172.18.0.4 centos-hadoop /bin/bash
echo "start hadoop-node2 container..."
docker run -itd --restart=always --net hadoop  --ip 172.18.0.3 --privileged -p 18042:8042 -p 51010:50010 -p 51020:50020 --name hadoop-node2 --hostname hadoop-node2 --add-host hadoop-node1:172.18.0.2 --add-host hadoop-node3:172.18.0.4 centos-hadoop  /bin/bash
echo "start hadoop-node3 container..."
docker run -itd --restart=always --net hadoop  --ip 172.18.0.4 --privileged -p 18043:8042 -p 51011:50011 -p 51021:50021 --name hadoop-node3 --hostname hadoop-node3 --add-host hadoop-node1:172.18.0.2 --add-host hadoop-node2:172.18.0.3  centos-hadoop /bin/bash

sleep 5
docker exec -it hadoop-node1 /usr/sbin/sshd
docker exec -it hadoop-node2 /usr/sbin/sshd
docker exec -it hadoop-node3 /usr/sbin/sshd
sleep 5
docker exec -it hadoop-node1 /usr/local/hadoop-2.8.5/start-hadoop.sh 

echo finished
docker ps
