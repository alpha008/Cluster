#!/bin/bash
execpath=$(cd "$(dirname "$0")"; pwd)
echo "current executed path is : ${execpath}"
M_FILES=mysql-5.6.45.tar.gz
M_DIR=mysql-5.6.45
M_PRE=/usr/local/mysql
M_URL=https://github.com/alpha008/mysql-5.6.45.git
function mysql_install()
{
    sudo apt-get install ncurses-dev
    sudo apt-get install bison
    sudo apt-get install perl
    sudo apt-get install libaio-dev
    if [ ! -d  ${M_DIR} ]; then
        git clone ${M_URL}  
    fi
    cd ${M_DIR}
    echo ${execpath}
    tar -xvf  mysql-5.6.45.tar.gz
    #cd ${M_DIR}
    sudo rm -rf /usr/local/mysql/*
    sudo mkdir -p /usr/local/mysql
    sudo mkdir -p /usr/local/mysql/data
    sudo groupadd mysql
    sudo useradd mysql -g mysql
    sudo chown -R mysql:mysql /usr/local/mysql
    cd ${M_DIR}
    sudo cmake -DCMAKE_INSTALL_PREFIX=/usr/local/mysql \
    -DMYSQL_DATADIR=/usr/local/mysql/data \
    -DWITH_MYISAM_STORAGE_ENGINE=1 \
    -DWITH_INNOBASE_STORAGE_ENGINE=1 \
    -DWITH_MEMORY_STORAGE_ENGINE=1 \
    -DWITH_READLINE=1 \
    -DMYSQL_TCP_PORT=3306 \
    -DENABLED_LOCAL_INFILE=1 \
    -DWITH_PARTITION_STORAGE_ENGINE=1 \
    -DEXTRA_CHARSETS=all  \
    -DDEFAULT_CHARSET=utf8  \
    -DDEFAULT_COLLATION=utf8_general_ci \
    -DWITH_DEBUG=0 \
    -DMYSQL_USER=mysql \
    -DMYSQL_UNIX_ADDR=/data/mysql/mysql.sock  
    sudo make -j6 
    sudo make install
    if [ $? -eq 0 ]; then
        echo "the mysql is successful"
    else
        echo "the mysql is failed"
        exit
    fi
}
function master_install()
{
    /bin/cp  ./$M_DIR/support-files/my-medium.cnf  /etc/my.cnf
    /bin/cp  ./$M_DIR/support-files/mysql.server   /etc/init.d/mysqld
    chmod 755  /etc/init.d/mysqld
    sed -i '38a datadir=/data/mysql' /etc/my.cnf
    sed -i '38a basedir=/usr/local/mysql' /etc/my.cnf
    sed -i '38a server_id = 1' /etc/my.cnf
    sed -i '38a log-bin=pc-bin' /etc/my.cnf #/usr/local/mysql/data
    /usr/local/mysql/scripts/mysql_install_db   --basedir=/usr/local/mysql   --datadir=/data/mysql  --user=mysql 
    /etc/init.d/mysqld  start
    chkconfig --add mysqld
    echo "PATH=$PATH:/usr/local/mysql/bin">>/etc/profile
    source  /etc/profile  >/dev/null 2>&1
}

function slave_install()
{
    /bin/cp  ./$M_DIR/support-files/my-medium.cnf  /etc/my.cnf
    /bin/cp  ./$M_DIR/support-files/mysql.server   /etc/init.d/mysqld
    chmod 755  /etc/init.d/mysqld
    echo "datadir=/data/mysql" >> /etc/my.cnf
    echo "basedir=/usr/local/mysql" >> /etc/my.cnf
    echo "server_id = 2" >> /etc/my.cnf
    /usr/local/mysql/scripts/mysql_install_db  --basedir=/usr/local/mysql   --datadir=/data/mysql  --user=mysql
    /etc/init.d/mysqld  start
    chkconfig --add mysqld
    echo "PATH=$PATH:/usr/local/mysql/bin">>/etc/profile
    source  /etc/profile  >/dev/null 2>&1
}

function master()
{
    ip=`ifconfig |grep "Bcast" |awk '{print $2}'|awk -F: '{print $2}'`
    file1=`mysql -e "show master status" |sed -n '2'p |awk '{print $1}'`
    point1=`mysql -e "show master status" |sed -n '2'p |awk '{print $2}'`
    read -p "please enter you tongbu yonghuming:" yonghu1
    echo -e "\033[36m you tongbu yonghuming is $yonghu1 \033[0m"
    read -p "please enter you tongbu mima:" mima1
    echo -e "\033[36m you tongbu mima is $mima1 \033[0m"
    read -p "please enter slave ip:" slave_ip
    echo -e "\033[36m the slave ip is $slave_ip \033[0m"
    mysql -e "grant replication slave on *.* to $yonghu1@'$slave_ip' identified by '$mima1';"
    mysql -e "flush privileges;"
    mysql -e "flush tables with read lock;"
    echo -e "\033[32m
    the master ip is $ip
    the tongbu file is $file1
    the tongbu point is $point1
    the tongbu yonghu is $yonghu1
    the tongbu mima is $mima1 \033[0m"
    sleep 60
    mysql -e "unlock tables;"
}

function slave()
{
    read -p "please enter the mysql master server ip:" master_ip
    echo -e "\033[36m the master server ip is $master_ip\033[0m"
    read -p "please enter the tongbu user:" tongbu2
    echo -e "\033[36m the tongbu user is $tongbu2 \033[0m"
    read -p "please enter the tongbu password:" mima2
    echo -e "\033[36m the tongbu password is $mima2 \033[0m"
    read -p "please enter the tongbu file:" file2
    echo -e "\033[36m the tongbu file is $file2  \033[0m"
    read -p "please enter the tongbu point:" point2
    echo -e "\033[36m the tongbu point is $point2  \033[0m"
    mysql -e "change master to master_host='$master_ip',master_user='$tongbu2',master_password='$mima2',master_log_file='$file2',master_log_pos=$point2;"
    mysql -e "flush privileges;"
    mysql -e "slave start;"
    mysql -e "show slave status\G;"
}

echo "
+--------------------------------------------+
|      欢迎使用mysql-master-slave搭建脚本    |
+--------------------------------------------+"

PS3="please select:"
echo "please input 1 :  mysql_install"
echo "please input 2 :  master_install"
echo "please input 3 :  slave_install"
flag=true
read -p "please input a number:" num
while $flag
do
   expr $num + 0 &>/dev/null
   [ $? -eq 0 ] && flag=false || read -p "please input a integer:" num
done
echo ${num}
case $num in
    1)
        mysql_install
    ;;
    2)
        master_install  &&  master
    ;;
    3)
        slave_install  &&  slave
    ;;
    *)
        echo "no this choice"
    ;;
esac