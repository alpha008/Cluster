修改进程打开的fd上限

ubuntu@VM-0-17-ubuntu:~/Cluster/redis/sentinel$ ulimit -a
core file size          (blocks, -c) 0
data seg size           (kbytes, -d) unlimited
scheduling priority             (-e) 0
file size               (blocks, -f) unlimited
pending signals                 (-i) 7086
max locked memory       (kbytes, -l) 65536
max memory size         (kbytes, -m) unlimited
open files                      (-n) 1024
pipe size            (512 bytes, -p) 8
POSIX message queues     (bytes, -q) 819200
real-time priority              (-r) 0
stack size              (kbytes, -s) 8192
cpu time               (seconds, -t) unlimited
max user processes              (-u) 7086
virtual memory          (kbytes, -v) unlimited
file locks                      (-x) unlimited



ubuntu@VM-0-17-ubuntu:~/Cluster/redis/sentinel$ ps -elf | grep redis
0 S ubuntu    3268     1  0  80   0 - 15484 ep_pol 22:59 pts/0    00:00:00 /home/ubuntu/Cluster/redis/sentinel/sentinel/redis11/redis-sentinel *:19001 [sentinel]
0 S ubuntu    3269     1  0  80   0 - 15484 ep_pol 22:59 pts/0    00:00:00 /home/ubuntu/Cluster/redis/sentinel/sentinel/redis12/redis-sentinel *:19002 [sentinel]
0 S ubuntu    3270     1  0  80   0 - 15484 ep_pol 22:59 pts/0    00:00:00 /home/ubuntu/Cluster/redis/sentinel/sentinel/redis13/redis-sentinel *:19003 [sentinel]
1 S ubuntu    3271     1  0  80   0 - 16124 ep_pol 22:59 ?        00:00:00 /home/ubuntu/Cluster/redis/sentinel/sentinel/redis12/redis-server 0.0.0.0:9002
1 S ubuntu    3272     1  0  80   0 - 16124 ep_pol 22:59 ?        00:00:00 /home/ubuntu/Cluster/redis/sentinel/sentinel/redis13/redis-server 0.0.0.0:9003
1 S ubuntu    3285     1  0  80   0 - 16124 ep_pol 22:59 ?        00:00:00 /home/ubuntu/Cluster/redis/sentinel/sentinel/redis11/redis-server 0.0.0.0:9001
0 S ubuntu    4408  2837  0  80   0 -  3445 pipe_w 23:06 pts/0    00:00:00 grep redis


redis-cli -p 9001
主能读写，备用不能写、只能读
下面看到了选举的过程，日志如下：  当主结点挂了之后
22844:X 18 Dec 2020 01:06:36.851 # +sdown master mymaster 172.16.0.17 9001
22850:X 18 Dec 2020 01:06:36.912 # +odown master mymaster 172.16.0.17 9001 #quorum 2/2
22850:X 18 Dec 2020 01:06:36.912 # +new-epoch 3
22850:X 18 Dec 2020 01:06:36.912 # +try-failover master mymaster 172.16.0.17 9001
22850:X 18 Dec 2020 01:06:36.916 # +vote-for-leader f15d635248356c36221834efa4a2e338fb1b1417 3
22862:X 18 Dec 2020 01:06:36.928 # +new-epoch 3
22844:X 18 Dec 2020 01:06:36.928 # +new-epoch 3
22844:X 18 Dec 2020 01:06:36.933 # +vote-for-leader f15d635248356c36221834efa4a2e338fb1b1417 3
22850:X 18 Dec 2020 01:06:36.933 # ba6757cd7b77c6212e036113cb7aa63d7886e8e9 voted for f15d635248356c36221834efa4a2e338fb1b1417 3
22862:X 18 Dec 2020 01:06:36.933 # +vote-for-leader f15d635248356c36221834efa4a2e338fb1b1417 3
22850:X 18 Dec 2020 01:06:36.933 # 8333c0118870a9bc1a155dcc07714c0e4c6231f0 voted for f15d635248356c36221834efa4a2e338fb1b1417 3
22844:X 18 Dec 2020 01:06:36.951 # +odown master mymaster 172.16.0.17 9001 #quorum 3/2
22844:X 18 Dec 2020 01:06:36.951 # Next failover delay: I will not start a failover before Fri Dec 18 01:07:17 2020
22850:X 18 Dec 2020 01:06:36.978 # +elected-leader master mymaster 172.16.0.17 9001
22850:X 18 Dec 2020 01:06:36.978 # +failover-state-select-slave master mymaster 172.16.0.17 9001
22850:X 18 Dec 2020 01:06:37.033 # +selected-slave slave 172.16.0.17:9003 172.16.0.17 9003 @ mymaster 172.16.0.17 9001
22850:X 18 Dec 2020 01:06:37.034 * +failover-state-send-slaveof-noone slave 172.16.0.17:9003 172.16.0.17 9003 @ mymaster 172.16.0.17 9001
22850:X 18 Dec 2020 01:06:37.100 * +failover-state-wait-promotion slave 172.16.0.17:9003 172.16.0.17 9003 @ mymaster 172.16.0.17 9001
22824:S 18 Dec 2020 01:06:37.738 * Connecting to MASTER 172.16.0.17:9001
22824:S 18 Dec 2020 01:06:37.738 * MASTER <-> REPLICA sync started
22824:S 18 Dec 2020 01:06:37.738 # Error condition on socket for SYNC: Operation now in progress
22850:X 18 Dec 2020 01:06:37.977 # +promoted-slave slave 172.16.0.17:9003 172.16.0.17 9003 @ mymaster 172.16.0.17 9001
22850:X 18 Dec 2020 01:06:37.977 # +failover-state-reconf-slaves master mymaster 172.16.0.17 9001
22862:X 18 Dec 2020 01:06:37.987 # +odown master mymaster 172.16.0.17 9001 #quorum 3/2
22862:X 18 Dec 2020 01:06:37.987 # Next failover delay: I will not start a failover before Fri Dec 18 01:07:17 2020
22850:X 18 Dec 2020 01:06:38.030 * +slave-reconf-sent slave 172.16.0.17:9002 172.16.0.17 9002 @ mymaster 172.16.0.17 9001
22824:S 18 Dec 2020 01:06:38.030 * REPLICAOF 172.16.0.17:9003 enabled (user request from 'id=8 addr=172.16.0.17:44340 fd=10 name=sentinel-f15d6352-cmd age=159 idle=1 flags=x db=0 sub=0 psub=0 multi=4 qbuf=336 qbuf-free=32432 obl=45 oll=0 omem=0 events=r cmd=exec user=default')
22824:S 18 Dec 2020 01:06:38.030 # CONFIG REWRITE executed with success.
22862:X 18 Dec 2020 01:06:38.031 # +config-update-from sentinel f15d635248356c36221834efa4a2e338fb1b1417 172.16.0.17 19002 @ mymaster 172.16.0.17 9001
22862:X 18 Dec 2020 01:06:38.031 # +switch-master mymaster 172.16.0.17 9001 172.16.0.17 9003
22862:X 18 Dec 2020 01:06:38.031 * +slave slave 172.16.0.17:9002 172.16.0.17 9002 @ mymaster 172.16.0.17 9003
22862:X 18 Dec 2020 01:06:38.031 * +slave slave 172.16.0.17:9001 172.16.0.17 9001 @ mymaster 172.16.0.17 9003
22844:X 18 Dec 2020 01:06:38.031 # +config-update-from sentinel f15d635248356c36221834efa4a2e338fb1b1417 172.16.0.17 19002 @ mymaster 172.16.0.17 9001
22844:X 18 Dec 2020 01:06:38.031 # +switch-master mymaster 172.16.0.17 9001 172.16.0.17 9003
22844:X 18 Dec 2020 01:06:38.032 * +slave slave 172.16.0.17:9002 172.16.0.17 9002 @ mymaster 172.16.0.17 9003
22844:X 18 Dec 2020 01:06:38.032 * +slave slave 172.16.0.17:9001 172.16.0.17 9001 @ mymaster 172.16.0.17 9003
22824:S 18 Dec 2020 01:06:38.740 * Connecting to MASTER 172.16.0.17:9003
22824:S 18 Dec 2020 01:06:38.740 * MASTER <-> REPLICA sync started
22824:S 18 Dec 2020 01:06:38.740 * Non blocking connect for SYNC fired the event.
22824:S 18 Dec 2020 01:06:38.740 * Master replied to PING, replication can continue...
22824:S 18 Dec 2020 01:06:38.740 * Trying a partial resynchronization (request 936f9eb5e9032dcd6d9903808c733744eef3bd09:31310).
22824:S 18 Dec 2020 01:06:38.740 * Successful partial resynchronization with master.
22824:S 18 Dec 2020 01:06:38.740 # Master replication ID changed to 06bbe2b1a5039676acb1ace8933d3969fefda94b
22824:S 18 Dec 2020 01:06:38.740 * MASTER <-> REPLICA sync: Master accepted a Partial Resynchronization.
22850:X 18 Dec 2020 01:06:39.032 * +slave-reconf-inprog slave 172.16.0.17:9002 172.16.0.17 9002 @ mymaster 172.16.0.17 9001
22850:X 18 Dec 2020 01:06:39.032 * +slave-reconf-done slave 172.16.0.17:9002 172.16.0.17 9002 @ mymaster 172.16.0.17 9001
22850:X 18 Dec 2020 01:06:39.098 # -odown master mymaster 172.16.0.17 9001
22850:X 18 Dec 2020 01:06:39.098 # +failover-end master mymaster 172.16.0.17 9001
22850:X 18 Dec 2020 01:06:39.098 # +switch-master mymaster 172.16.0.17 9001 172.16.0.17 9003
22850:X 18 Dec 2020 01:06:39.098 * +slave slave 172.16.0.17:9002 172.16.0.17 9002 @ mymaster 172.16.0.17 9003
22850:X 18 Dec 2020 01:06:39.098 * +slave slave 172.16.0.17:9001 172.16.0.17 9001 @ mymaster 172.16.0.17 9003
22844:X 18 Dec 2020 01:06:41.040 # +sdown slave 172.16.0.17:9001 172.16.0.17 9001 @ mymaster 172.16.0.17 9003
22862:X 18 Dec 2020 01:06:41.083 # +sdown slave 172.16.0.17:9001 172.16.0.17 9001 @ mymaster 172.16.0.17 9003
22850:X 18 Dec 2020 01:06:42.122 # +sdown slave 172.16.0.17:9001 172.16.0.17 9001 @ mymaster 172.16.0.17

