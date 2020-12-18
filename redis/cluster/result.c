总共16384个槽

ubuntu@VM-0-17-ubuntu:~/Cluster/redis/cluster$ redis-cli --cluster create 172.16.0.17:10001 172.16.0.17:10002 172.16.0.17:10003 172.16.0.17:10004 172.16.0.17:10005 172.16.0.17:10006 --cluster-replicas 1
>>> Performing hash slots allocation on 6 nodes...
Master[0] -> Slots 0 - 5460
Master[1] -> Slots 5461 - 10922
Master[2] -> Slots 10923 - 16383
Adding replica 172.16.0.17:10005 to 172.16.0.17:10001
Adding replica 172.16.0.17:10006 to 172.16.0.17:10002
Adding replica 172.16.0.17:10004 to 172.16.0.17:10003
>>> Trying to optimize slaves allocation for anti-affinity
[WARNING] Some slaves are in the same host as their master
M: 458f6515c8738c236a4d8c6af9a9fc2bcff75dca 172.16.0.17:10001
   slots:[0-5460] (5461 slots) master
M: 2a656eb9159e8a41bba688b3d4e7ae223b65ca96 172.16.0.17:10002
   slots:[5461-10922] (5462 slots) master
M: 00cf8ccde1a6e2d41f5f5374afb51b7c75aadd37 172.16.0.17:10003
   slots:[10923-16383] (5461 slots) master
S: 01bab3233cbbf1ad6d572ec533f3fab797809edb 172.16.0.17:10004
   replicates 00cf8ccde1a6e2d41f5f5374afb51b7c75aadd37
S: 93308d0d2397869653c79737619faa166de515b5 172.16.0.17:10005
   replicates 458f6515c8738c236a4d8c6af9a9fc2bcff75dca
S: 77efe747dae043fdca62f1131a4cb6996874a766 172.16.0.17:10006
   replicates 2a656eb9159e8a41bba688b3d4e7ae223b65ca96
Can I set the above configuration? (type 'yes' to accept): yes
>>> Nodes configuration updated
>>> Assign a different config epoch to each node
>>> Sending CLUSTER MEET messages to join the cluster
Waiting for the cluster to join
......
>>> Performing Cluster Check (using node 172.16.0.17:10001)
M: 458f6515c8738c236a4d8c6af9a9fc2bcff75dca 172.16.0.17:10001
   slots:[0-5460] (5461 slots) master
   1 additional replica(s)
S: 01bab3233cbbf1ad6d572ec533f3fab797809edb 172.16.0.17:10004
   slots: (0 slots) slave
   replicates 00cf8ccde1a6e2d41f5f5374afb51b7c75aadd37
M: 00cf8ccde1a6e2d41f5f5374afb51b7c75aadd37 172.16.0.17:10003
   slots:[10923-16383] (5461 slots) master
   1 additional replica(s)
S: 93308d0d2397869653c79737619faa166de515b5 172.16.0.17:10005
   slots: (0 slots) slave
   replicates 458f6515c8738c236a4d8c6af9a9fc2bcff75dca
S: 77efe747dae043fdca62f1131a4cb6996874a766 172.16.0.17:10006
   slots: (0 slots) slave
   replicates 2a656eb9159e8a41bba688b3d4e7ae223b65ca96
M: 2a656eb9159e8a41bba688b3d4e7ae223b65ca96 172.16.0.17:10002
   slots:[5461-10922] (5462 slots) master
   1 additional replica(s)
[OK] All nodes agree about slots configuration.
>>> Check for open slots...
>>> Check slots coverage...
[OK] All 16384 slots covered.



test 
redis-cli -p 10001 -c 
