#!/bin/sh
/home/ubuntu/Cluster/redis/cluster/redis01/redis-server  /home/ubuntu/Cluster/redis/cluster/redis01/redis.conf 
/home/ubuntu/Cluster/redis/cluster/redis02/redis-server  /home/ubuntu/Cluster/redis/cluster/redis02/redis.conf &
/home/ubuntu/Cluster/redis/cluster/redis03/redis-server  /home/ubuntu/Cluster/redis/cluster/redis03/redis.conf &
/home/ubuntu/Cluster/redis/cluster/redis04/redis-server  /home/ubuntu/Cluster/redis/cluster/redis04/redis.conf &
/home/ubuntu/Cluster/redis/cluster/redis05/redis-server  /home/ubuntu/Cluster/redis/cluster/redis05/redis.conf &
/home/ubuntu/Cluster/redis/cluster/redis06/redis-server  /home/ubuntu/Cluster/redis/cluster/redis06/redis.conf &


##ps -ef | grep redis | grep -v grep | awk '{print $2}' | xargs kill -9
