#!/bin/sh

#mkdir -p /home/ubuntu/Cluster/mongodb/master-slave

#mkdir -p /home/ubuntu/Cluster/mysql/master-slave
#1. 创建master-slave
mkdir -p /home/ubuntu/Cluster/redis/master-slave/master-slave
#2. 创建下面三个文件
cd /home/ubuntu/Cluster/redis/master-slave/master-slave
mkdir redis11 redis12 redis13
#3. 拷贝服务器文件到上面三个文件内
cp /usr/local/bin/redis-server /home/ubuntu/Cluster/redis/master-slave/master-slave/redis11
cp /usr/local/bin/redis-server /home/ubuntu/Cluster/redis/master-slave/master-slave/redis12
cp /usr/local/bin/redis-server /home/ubuntu/Cluster/redis/master-slave/master-slave/redis13
#4.拷贝客户端文件到下面文件内
cp /usr/local/bin/redis-cli /home/ubuntu/Cluster/redis/master-slave/master-slave
#5. 拷贝配置文件
cp /home/alpha/share/redis-6.0.3/redis-6.0.3/redis.conf /home/ubuntu/Cluster/redis/master-slave/master-slave/redis11/redis1.conf
cp /home/alpha/share/redis-6.0.3/redis-6.0.3/redis.conf /home/ubuntu/Cluster/redis/master-slave/master-slave/redis12/redis2.conf
cp /home/alpha/share/redis-6.0.3/redis-6.0.3/redis.conf /home/ubuntu/Cluster/redis/master-slave/master-slave/redis13/redis3.conf

#slaveof 182.254.181.144 8001


