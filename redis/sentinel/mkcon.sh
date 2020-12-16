#!/bin/sh
#1. 创建sentinel
mkdir -p /home/ubuntu/Cluster/redis/sentinel/sentinel

cd /home/ubuntu/Cluster/redis/sentinel/sentinel
mkdir redis11 redis12 redis13

cp /usr/local/bin/redis-server /home/ubuntu/Cluster/redis/sentinel/sentinel/redis11
cp /usr/local/bin/redis-server /home/ubuntu/Cluster/redis/sentinel/sentinel/redis12
cp /usr/local/bin/redis-server /home/ubuntu/Cluster/redis/sentinel/sentinel/redis13

cp /usr/local/bin/redis-sentinel /home/ubuntu/Cluster/redis/sentinel/sentinel/redis11
cp /usr/local/bin/redis-sentinel /home/ubuntu/Cluster/redis/sentinel/sentinel/redis12
cp /usr/local/bin/redis-sentinel /home/ubuntu/Cluster/redis/sentinel/sentinel/redis13

cp /usr/local/bin/redis-cli /home/ubuntu/Cluster/redis/sentinel/sentinel/redis11
cp /usr/local/bin/redis-cli /home/ubuntu/Cluster/redis/sentinel/sentinel/redis12
cp /usr/local/bin/redis-cli /home/ubuntu/Cluster/redis/sentinel/sentinel/redis13


cp /home/alpha/share/redis-6.0.3/redis-6.0.3/sentinel.conf /home/ubuntu/Cluster/redis/sentinel/sentinel/redis11/sentinel1.conf
cp /home/alpha/share/redis-6.0.3/redis-6.0.3/sentinel.conf /home/ubuntu/Cluster/redis/sentinel/sentinel/redis12/sentinel2.conf
cp /home/alpha/share/redis-6.0.3/redis-6.0.3/sentinel.conf /home/ubuntu/Cluster/redis/sentinel/sentinel/redis13/sentinel3.conf
touch /home/ubuntu/Cluster/redis/sentinel/sentinel/redis11/redis1.conf
touch /home/ubuntu/Cluster/redis/sentinel/sentinel/redis12/redis2.conf
touch /home/ubuntu/Cluster/redis/sentinel/sentinel/redis13/redis3.conf
#cp /home/ubuntu/Cluster/redis/master-slave/master-slave/redis11/redis1.conf /home/ubuntu/Cluster/redis/sentinel/sentinel/redis11/redis1.conf
#cp /home/ubuntu/Cluster/redis/master-slave/master-slave/redis12/redis2.conf /home/ubuntu/Cluster/redis/sentinel/sentinel/redis12/redis2.conf
#cp /home/ubuntu/Cluster/redis/master-slave/master-slave/redis13/redis3.conf /home/ubuntu/Cluster/redis/sentinel/sentinel/redis13/redis3.conf

#sentinel monitor mymaster 172.16.0.17 9001 2
#sentinel monitor mymaster 172.16.0.17 9002 2
#sentinel monitor mymaster 172.16.0.17 9003 2
