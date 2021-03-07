#/bin/sh
execpath=$(cd "$(dirname "$0")"; pwd)
echo "current executed path is : ${execpath}"
#sudo apt-get install mysql-server-5.7
#wget http://dev.mysql.com/get/Downloads/MySQL-5.7/mysql-5.7.17-linux-glibc2.5-x86_64.tar.gz
file_mysql_src="mysql_source"
file_mysql_tar="mysql-5.7.17-linux-glibc2.5-x86_64.tar.gz"
file_mysql="mysql-5.7.17-linux-glibc2.5-x86_64"
if [ ! -d "$file_mysql_src" ]; then
    echo ''${file_mysql_src}' is not exist'
    sudo mkdir -p ${file_mysql_src}
    cd ${file_mysql_src}
    sudo  wget http://dev.mysql.com/get/Downloads/MySQL-5.7/mysql-5.7.17-linux-glibc2.5-x86_64.tar.gz
    echo 'download '${file_mysql_tar}' sucess'
    sudo tar -xvf ${file_mysql_tar}
    #sudo mv ${file_mongo} /usr/local/mongodb
    #vim /etc/profile  # 添加环境变量
    #在/etc/profile 最后一行，添加 export PATH=/usr/local/mongodb/bin:$PATH
    #source /etc/profile
    #sudo sed -i '$a\export PATH=/usr/local/mongodb/bin:$PATH'  /etc/profile
    #sudo cat /etc/profile
    #source /etc/profile
    sudo mv  mysql-5.7.17-linux-glibc2.5-x86_64 /usr/local/mysql
    echo "------------------------"
    echo ${execpath}
fi
cd ${execpath}
#数据库位置
if [ ! -d "mysql" ]; then
    sudo mkdir -p mysql
fi
#日志位置
if [ ! -d "mysql/log" ]; then
    sudo mkdir -p mysql/log
fi
#新建mysql用户、组及目录
sudo useradd -r -s /sbin/nologin -g mysql mysql -d /usr/local/mysql

#---新建一个msyql组
# useradd -r -s /sbin/nologin -g mysql mysql -d /usr/local/mysql     ---新建msyql用户禁止登录shell
#改变目录属有者
if [ ! -d "/usr/local/mysql" ]; then
    sudo mkdir -p /usr/local/mysql
    cd /usr/local/mysql
    pwd
    sudo chown -R mysql .
    sudo chgrp -R mysql .
    cd ${execpath}
    sudo chown -R mysql ${execpath}/mysql
fi
cd ${execpath}
/usr/local/mysql/mysql-5.7.17-linux-glibc2.5-x86_64/bin/mysqld --initialize --user=mysql --basedir=/usr/local/mysql --datadir=${execpath}/mysql
/usr/local/mysql/bin/mysqld --initialize --user=mysql --basedir=/usr/local/mysql --datadir=/usr/local/mysql


