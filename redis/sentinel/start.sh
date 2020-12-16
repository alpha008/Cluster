#!/bin/sh
/home/ubuntu/Cluster/redis/sentinel/sentinel/redis11/redis-server /home/ubuntu/Cluster/redis/sentinel/sentinel/redis11/redis1.conf &
/home/ubuntu/Cluster/redis/sentinel/sentinel/redis12/redis-server /home/ubuntu/Cluster/redis/sentinel/sentinel/redis12/redis2.conf &
/home/ubuntu/Cluster/redis/sentinel/sentinel/redis13/redis-server /home/ubuntu/Cluster/redis/sentinel/sentinel/redis13/redis3.conf &

/home/ubuntu/Cluster/redis/sentinel/sentinel/redis11/redis-sentinel /home/ubuntu/Cluster/redis/sentinel/sentinel/redis11/sentinel1.conf &
/home/ubuntu/Cluster/redis/sentinel/sentinel/redis12/redis-sentinel /home/ubuntu/Cluster/redis/sentinel/sentinel/redis12/sentinel2.conf &
/home/ubuntu/Cluster/redis/sentinel/sentinel/redis13/redis-sentinel /home/ubuntu/Cluster/redis/sentinel/sentinel/redis13/sentinel3.conf &




#ps -ef | grep redis | grep -v grep | awk '{print $2}' | xargs kill -9