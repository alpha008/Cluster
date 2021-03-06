#/bin/sh
execpath=$(cd "$(dirname "$0")"; pwd)
echo "current executed path is : ${execpath}"
#1.查看状态
ps -elf | grep mysql
#2.创建目录
if [ ! -d "${execpath}/conf/mysql_3306/run" ]; then
    echo ''${execpath}/conf/mysql_3306/run' is not exist'
    mkdir -p ${execpath}/conf/mysql_3306/run
fi
if [ ! -d "${execpath}/conf/mysql_3306/log" ]; then
    echo ''${execpath}/conf/mysql_3306/log' is not exist'
    mkdir -p ${execpath}/conf/mysql_3306/log
fi
if [ ! -d "${execpath}/conf/mysql_3306/tmp" ]; then
    echo ''${execpath}/conf/mysql_3306/tmp' is not exist'
    mkdir -p ${execpath}/conf/mysql_3306/tmp
fi
if [ ! -d "${execpath}/conf/mysql_3306/data" ]; then
    echo ''${execpath}/conf/mysql_3306/data' is not exist'
    mkdir -p ${execpath}/conf/mysql_3306/data
fi
if [ ! -d "${execpath}/conf/mysql_3307/run" ]; then
    echo ''${execpath}/conf/mysql_3307/run' is not exist'
    mkdir -p ${execpath}/conf/mysql_3307/run
fi
if [ ! -d "${execpath}/conf/mysql_3307/log" ]; then
    echo ''${execpath}/conf/mysql_3307/log' is not exist'
    mkdir -p ${execpath}/conf/mysql_3307/log
fi
if [ ! -d "${execpath}/conf/mysql_3307/tmp" ]; then
    echo ''${execpath}/conf/mysql_3307/tmp' is not exist'
    mkdir -p ${execpath}/conf/mysql_3307/tmp
fi
if [ ! -d "${execpath}/conf/mysql_3307/data" ]; then
    echo ''${execpath}/conf/mysql_3307/data' is not exist'
    mkdir -p ${execpath}/conf/mysql_3307/data
fi

#3.配置主
#${file%%.*}：删掉第一个 . 及其右边的字符串：/dir1/dir2/dir3/my
cp /etc/mysql/mysql.conf.d/mysqld.cnf ./master.cnf
target=$(cat master.cnf | grep -n "log_error")
line=$(echo $target | awk -F ":" '{print $1}')
text=$(echo $target | awk -F ":" '{print $2}')
target=${text%%=*}=${execpath}/conf/mysql_3306/log/3306.log
h="'";
cmd="sed -i ${h}${line}c ${target}${h} master.cnf"
eval ${cmd}

target=$(cat master.cnf | grep -n "datadir")
line=$(echo $target | awk -F ":" '{print $1}')
text=$(echo $target | awk -F ":" '{print $2}')
target=${text%%=*}=${execpath}/conf/mysql_3306/data
h="'";
cmd="sed -i ${h}${line}c ${target}${h} master.cnf"
eval ${cmd}

target=$(cat master.cnf | grep -n "mysqld.sock")
line=$(echo $target | awk -F ":" '{print $1}')
text=$(echo $target | awk -F ":" '{print $2}')
target=${text%%=*}=${execpath}/conf/mysql_3306/tmp/mysql_3306.sock
h="'";
cmd="sed -i ${h}${line}c ${target}${h} master.cnf"
eval ${cmd}

target=$(cat master.cnf | grep -n "mysqld.sock")
line=$(echo $target | awk -F ":" '{print $1}')
text=$(echo $target | awk -F ":" '{print $2}')
target=${text%%=*}=${execpath}/conf/mysql_3306/tmp/mysql_3306.sock
h="'";
cmd="sed -i ${h}${line}c ${target}${h} master.cnf"
eval ${cmd}

target=$(cat master.cnf | grep -n "slow_query_log_file")
line=$(echo $target | awk -F ":" '{print $1}')
text=$(echo $target | awk -F ":" '{print $2}')
temp=${text#*#}
target=${temp%%=*}=${execpath}/conf/mysql_3306/log/slow.log
h="'";
cmd="sed -i ${h}${line}c ${target}${h} master.cnf"
eval ${cmd}

target=$(cat master.cnf | grep -n "pid-file")
line=$(echo $target | awk -F ":" '{print $1}')
text=$(echo $target | awk -F ":" '{print $2}')
temp=${text#*#}
target=${temp%%=*}=${execpath}/conf/mysql_3306/run/mysqld.pid
h="'";
cmd="sed -i ${h}${line}c ${target}${h} master.cnf"
eval ${cmd}

target=$(cat master.cnf | grep -n "tmpdir")
line=$(echo $target | awk -F ":" '{print $1}')
text=$(echo $target | awk -F ":" '{print $2}')
temp=${text#*#}
target=${temp%%=*}=${execpath}/conf/mysql_3306/tmp
h="'";
cmd="sed -i ${h}${line}c ${target}${h} master.cnf"
eval ${cmd}



sed -i 's/^user.*/user=root/g' master.cnf

sed -i '/slow_query_log/a\bind-address=0.0.0.0' master.cnf
sed -i 's/\[mysqld\]$/[mysqld3306]/g' master.cnf
sed -i 's/^port.*/port=3306/g' master.cnf
sed -i '/address/d' master.cnf
sed -i '/localhost/a\bind-address=0.0.0.0' master.cnf

sed -i '/server-id/d' master.cnf
sed -i '/expire_logs_days/a\server-id=3306' master.cnf

#4.配置备

cp /etc/mysql/mysql.conf.d/mysqld.cnf ./slave.cnf
target=$(cat slave.cnf | grep -n "log_error")
line=$(echo $target | awk -F ":" '{print $1}')
text=$(echo $target | awk -F ":" '{print $2}')
target=${text%%=*}=${execpath}/conf/mysql_3307/log/3307.log
h="'";
cmd="sed -i ${h}${line}c ${target}${h} slave.cnf"
eval ${cmd}

target=$(cat slave.cnf | grep -n "datadir")
line=$(echo $target | awk -F ":" '{print $1}')
text=$(echo $target | awk -F ":" '{print $2}')
target=${text%%=*}=${execpath}/conf/mysql_3307/data
h="'";
cmd="sed -i ${h}${line}c ${target}${h} slave.cnf"
eval ${cmd}

target=$(cat slave.cnf | grep -n "mysqld.sock")
line=$(echo $target | awk -F ":" '{print $1}')
text=$(echo $target | awk -F ":" '{print $2}')
target=${text%%=*}=${execpath}/conf/mysql_3307/tmp/mysql_3306.sock
h="'";
cmd="sed -i ${h}${line}c ${target}${h} slave.cnf"
eval ${cmd}

target=$(cat slave.cnf | grep -n "mysqld.sock")
line=$(echo $target | awk -F ":" '{print $1}')
text=$(echo $target | awk -F ":" '{print $2}')
target=${text%%=*}=${execpath}/conf/mysql_3307/tmp/mysql_3306.sock
h="'";
cmd="sed -i ${h}${line}c ${target}${h} slave.cnf"
eval ${cmd}

target=$(cat slave.cnf | grep -n "slow_query_log_file")
line=$(echo $target | awk -F ":" '{print $1}')
text=$(echo $target | awk -F ":" '{print $2}')
temp=${text#*#}
target=${temp%%=*}=${execpath}/conf/mysql_3307/log/slow.log
h="'";
cmd="sed -i ${h}${line}c ${target}${h} slave.cnf"
eval ${cmd}

target=$(cat slave.cnf | grep -n "pid-file")
line=$(echo $target | awk -F ":" '{print $1}')
text=$(echo $target | awk -F ":" '{print $2}')
temp=${text#*#}
target=${temp%%=*}=${execpath}/conf/mysql_3307/run/mysqld.pid
h="'";
cmd="sed -i ${h}${line}c ${target}${h} slave.cnf"
eval ${cmd}

target=$(cat slave.cnf | grep -n "tmpdir")
line=$(echo $target | awk -F ":" '{print $1}')
text=$(echo $target | awk -F ":" '{print $2}')
temp=${text#*#}
target=${temp%%=*}=${execpath}/conf/mysql_3307/tmp
h="'";
cmd="sed -i ${h}${line}c ${target}${h} slave.cnf"
eval ${cmd}

target=$(cat slave.cnf | grep -n "user")
line=$(echo $target | awk -F ":" '{print $1}')
text=$(echo $target | awk -F ":" '{print $2}')
target=${text%%=*}=root
h="'";
cmd="sed -i ${h}${line}c ${target}${h} slave.cnf"
eval ${cmd}

sed -i 's/^user.*/user=root/g' master.cnf
sed -i '/slow_query_log/a\bind-address=0.0.0.0' slave.cnf
sed -i 's/\[mysqld\]$/[mysqld3307]/g' slave.cnf
sed -i 's/^port.*/port=3307/g' slave.cnf
sed -i '/address/d' slave.cnf
sed -i '/localhost/a\bind-address=0.0.0.0' slave.cnf

sed -i '/server-id/d' slave.cnf
sed -i '/expire_logs_days/a\server-id=3307' slave.cnf


