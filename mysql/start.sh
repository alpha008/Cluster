#/bin/sh
execpath=$(cd "$(dirname "$0")"; pwd)
echo "current executed path is : ${execpath}"
#1.查看状态
netstat -ano | grep mysql
#2.创建目录
sudo mkdir -p ${execpath}/conf/mysql_3306/log
sudo mkdir -p ${execpath}/conf/mysql_3306/tmp
sudo mkdir -p ${execpath}/conf/mysql_3306/data
sudo mkdir -p ${execpath}/conf/mysql_3307/log
sudo mkdir -p ${execpath}/conf/mysql_3307/tmp
sudo mkdir -p ${execpath}/conf/mysql_3307/data
#3.更改目录权限
#任意目录下，输入

#4.添加环境变量
sudo sed -i '$a\export PATH=$PATH:/usr/local/mysql/bin'  /etc/profile
source /etc/profile
#5.复制my.cnf文件到etc目录
cp /etc/mysql/mysql.conf.d/mysqld.cnf /etc/my.cnf

#6.修改my.cnf（在一个文件中修改即可）
#3306数据库
[mysqld3306]
mysqld=mysqld
mysqladmin=mysqladmin
datadir=/data/mysql/mysql_3306/data
port=3306
server_id=3306
socket=/tmp/mysql_3306.sock
log-output=file
slow_query_log = 1
long_query_time = 1
slow_query_log_file = /data/mysql/mysql_3306/log/slow.log
log-error = /data/mysql/mysql_3306/log/error.log
binlog_format = mixed
log-bin = /data/mysql/mysql_3306/log/mysql3306_bin
#3307数据库
[mysqld3307]
mysqld=mysqld
mysqladmin=mysqladmin
datadir=/data/mysql/mysql_3307/data
port=3307
server_id=3307
socket=/tmp/mysql_3307.sock
log-output=file
slow_query_log = 1
long_query_time = 1
slow_query_log_file = /data/mysql/mysql_3307/log/slow.log
log-error = /data/mysql/mysql_3307/log/error.log
binlog_format = mixed
log-bin = /data/mysql/mysql_3307/log/mysql3307_bin
#3308数据库

[mysqld3308]
mysqld=mysqld
mysqladmin=mysqladmin
datadir=/data/mysql/mysql_3308/data
port=3308
server_id=3308
socket=/tmp/mysql_3308.sock
log-output=file
slow_query_log = 1
long_query_time = 1
slow_query_log_file = /data/mysql/mysql_3308/log/slow.log
log-error = /data/mysql/mysql_3308/log/error.log
binlog_format = mixed
log-bin = /data/mysql/mysql_3308/log/mysql3308_bin



#初始化数据库
#初始化3306数据库 
/usr/local/mysql/scripts/mysql_install_db --basedir=/usr/local/mysql/ --datadir=/data/mysql/mysql_3306/data --defaults-file=/etc/my.cnf  
#初始化3307数据库 
/usr/local/mysql/scripts/mysql_install_db --basedir=/usr/local/mysql/ --datadir=/data/mysql/mysql_3307/data --defaults-file=/etc/my.cnf
#初始化3308数据库 
/usr/local/mysql/scripts/mysql_install_db --basedir=/usr/local/mysql/ --datadir=/data/mysql/mysql_3308/data --defaults-file=/etc/my.cnf

#查看数据库是否初始化成功

查看3306、3307、3308数据库

cd /data/mysql/mysql_3306/data/
cd /data/mysql/mysql_3307/data/
cd /data/mysql/mysql_3308/data/
设置启动文件
cp /usr/local/mysql/support-files/mysql.server /etc/init.d/mysql

mysqld_multi进行多实例管理
启动全部实例：/usr/local/mysql/bin/mysqld_multi start

查看全部实例状态：/usr/local/mysql/bin/mysqld_multi report 

启动单个实例：/usr/local/mysql/bin/mysqld_multi start 3306 

停止单个实例：/usr/local/mysql/bin/mysqld_multi stop 3306 

查看单个实例状态：/usr/local/mysql/bin/mysqld_multi report 3306 
#启动全部实例

/usr/local/mysql/bin/mysqld_multi start
/usr/local/mysql/bin/mysqld_multi report

# 查看启动进程

ps -aux | grep mysql

#进入tmp目录，查看sock文件

cd /tmp

修改密码
mysql的root用户初始密码是空，所以需要登录mysql进行修改密码，下面以3306为例：

mysql -S /tmp/mysql_3306.sock
set password for root@'localhost'=password('xxxxxx');
flush privileges;


#修改3307数据库密码

mysql -S /tmp/mysql_3307.sock
set password for root@'localhost'=password('xxxxxx');
flush privileges;
#修改3308数据库密码

mysql -S /tmp/mysql_3307.sock
set password for root@'localhost'=password('xxxxxx');
flush privileges;
新建用户及授权
一般新建数据库都需要新增一个用户，用于程序连接，这类用户只需要insert、update、delete、select权限。这里赋予所有权限，以3306为例，3307、3308相同。

#新增一个用户，并授权如下： 

grant ALL PRIVILEGES on *.* to admin@'%' identified by 'xxxxxx'; 
flush privileges



