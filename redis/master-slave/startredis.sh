#!/bin/sh
#ps -ef | grep redis | grep -v grep | awk '{print $2}' | xargs kill -9
/usr/local/bin/redis-server /home/ubuntu/Cluster/redis/master-slave/master-slave/redis11/redis1.conf &
/usr/local/bin/redis-server /home/ubuntu/Cluster/redis/master-slave/master-slave/redis12/redis2.conf &
/usr/local/bin/redis-server /home/ubuntu/Cluster/redis/master-slave/master-slave/redis13/redis3.conf &
#netstat –anop | grep redis


#ps -ef | grep redis | grep -v grep | awk '{print $2}' | xargs kill -9