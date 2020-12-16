#!/bin/sh

#配置文件做如下修改
#bind 0.0.0.0
#主机1port 8001 从机1port 8002 从机1 port 8003
#logfile "8001.log" logfile "8002.log" logfile "8003.log"
#daemonize yes 
#rdbcompression yes
#从机12中需要加上slaveof 172.16.0.17 8001

netstat –anop | grep redis
/usr/local/bin/redis-cli -p $1


#验证结果如下：
#ubuntu@VM-0-17-ubuntu:~/Cluster/redis/master-slave$ redis-cli -p 8001
#127.0.0.1:8001> set zjx king
#OK
#127.0.0.1:8001> quit
#ubuntu@VM-0-17-ubuntu:~/Cluster/redis/master-slave$ redis-cli -p 8002
#127.0.0.1:8002> get zjx
#"king"
#127.0.0.1:8002> quit
#ubuntu@VM-0-17-ubuntu:~/Cluster/redis/master-slave$ redis-cli -p 8003
#127.0.0.1:8003> get zjx
#"king"
#127.0.0.1:8003> quit
