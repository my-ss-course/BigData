#!/bin/bash

echo clean containers

docker ps -a

docker kill $(docker ps -a -q)

docker rm $(docker ps -q -f status=exited)

docker ps -a
