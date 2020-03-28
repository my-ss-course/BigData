#!/bin/bash

$HADOOP_HOME/sbin/stop-all.sh
$HADOOP_HOME/sbin/start-dfs.sh
$HADOOP_HOME/sbin/start-yarn.sh


