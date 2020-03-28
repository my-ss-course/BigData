#!/bin/bash

echo build centos-hadoop images

docker build -t="centos-hadoop" .
