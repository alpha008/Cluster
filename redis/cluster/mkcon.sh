#!/bin/sh
#1. 创建sentinel
mkdir -p /home/ubuntu/Cluster/redis/cluster/redis01
mkdir -p /home/ubuntu/Cluster/redis/cluster/redis02
mkdir -p /home/ubuntu/Cluster/redis/cluster/redis03
mkdir -p /home/ubuntu/Cluster/redis/cluster/redis04
mkdir -p /home/ubuntu/Cluster/redis/cluster/redis05
mkdir -p /home/ubuntu/Cluster/redis/cluster/redis06

 cp /home/alpha/share/redis-6.0.3/redis-6.0.3/redis.conf /home/ubuntu/Cluster/redis/cluster/redis01
 cp /home/alpha/share/redis-6.0.3/redis-6.0.3/redis.conf /home/ubuntu/Cluster/redis/cluster/redis02
 cp /home/alpha/share/redis-6.0.3/redis-6.0.3/redis.conf /home/ubuntu/Cluster/redis/cluster/redis03
 cp /home/alpha/share/redis-6.0.3/redis-6.0.3/redis.conf /home/ubuntu/Cluster/redis/cluster/redis04
 cp /home/alpha/share/redis-6.0.3/redis-6.0.3/redis.conf /home/ubuntu/Cluster/redis/cluster/redis05
 cp /home/alpha/share/redis-6.0.3/redis-6.0.3/redis.conf /home/ubuntu/Cluster/redis/cluster/redis06

#bind 0.0.0.0
#port 10001
#cluster-enabled yes
#daemonize yes


