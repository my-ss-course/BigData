#!/bin/bash

echo stop containers 
docker stop hadoop-node1
docker stop hadoop-node2
docker stop hadoop-node3

docker ps -a


