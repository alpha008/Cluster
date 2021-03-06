#/bin/sh
execpath=$(cd "$(dirname "$0")"; pwd)
echo "current executed path is : ${execpath}"
#1.查看状态
ps -elf | grep mysql

sudo netstat -antp | grep mysql
#2.启动mysql /etc/init.d/mysql
 
sudo  mysqld start --defaults-file=${execpath}/master.cnf --user=root &
sudo  mysqld  start --defaults-file=${execpath}/slave.cnf --user=root &
#mysqld --defaults-file=/etc/my.cnf --user=root
#mysql -uroot -P3306 -p121867
#mysql -uroot -P3307 -p121867
echo "-------------------------------------" 
ps -elf | grep mysql | grep -v grep 
echo "-------------------------------------" 
ps aux|grep 3306
ps aux|grep 3307
#show slave status;
#show master status;






