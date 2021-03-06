#/bin/sh
execpath=$(cd "$(dirname "$0")"; pwd)
echo "current executed path is : ${execpath}"
#sudo apt-get install mysql-server-5.7
#wget http://dev.mysql.com/get/Downloads/MySQL-5.7/mysql-5.7.17-linux-glibc2.5-x86_64.tar.gz
sudo mkdir -p  /usr/local/src
cd /usr/local/src
#sudo wget http://www.cmake.org/files/v2.8/cmake-2.8.11.1.tar.gz
sudo wget http://ftp.gnu.org/gnu/bison/bison-2.7.tar.gz
sudo wget http://ftp.gnu.org/gnu/m4/m4-1.4.16.tar.gz
sudo wget http://www.mysql.com/get/Downloads/MySQL-5.6/mysql-5.6.12.tar.gz/from/http://cdn.mysql.com/

#安装cmake编译器
#cd /usr/local/src
#sudo tar -xvf cmake-2.8.11.1.tar.gz
#cd cmake-2.8.11.1
#sudo ./bootstrap
#sudo make && make install

#安装m4
cd /usr/local/src
sudo tar -xvf m4-1.4.16.tar.gz
cd m4-1.4.16
sudo ./configure && make && make install

#安装bison
cd /usr/local/src
sudo tar -xvf bison-2.7.tar.gz
cd bison-2.7
sudo ./configure && make && make install

#创建mysql用户与组，相关目录
sudo /usr/sbin/groupadd mysql
sudo /usr/sbin/useradd -g mysql mysql
sudo mkdir -p /app/soft/mysql
sudo chown -R mysql:mysql /app/soft/mysql
sudo mkdir -p /data/mysqldata
sudo chown -R mysql:mysql /data/mysqldata/
cd /usr/local/src
sudo tar -xvf mysql-5.6.12.tar.gz
export CFLAGS="-O3 -g -fno-exceptions -static-libgcc -fno-omit-frame-pointer -fno-strict-aliasing"
export CXXFLAGS="-O3 -g -fno-exceptions -fno-rtti -static-libgcc -fno-omit-frame-pointer -fno-strict-aliasing"
export CXX=g++
cd mysql-5.6.12
cmake -DCMAKE_INSTALL_PREFIX=/app/soft/mysql/ -DMYSQL_UNIX_ADDR=/tmp/mysql.sock
    -DDEFAULT_CHARSET=utf8 -DDEFAULT_COLLATION=utf8_general_ci -DWITH_EXTRA_CHARSETS=utf8,gbk 
    -DWITH_PERFSCHEMA_STORAGE_ENGINE=1 -DWITH_FEDERATED_STORAGE_ENGINE=1 -DWITH_PARTITION_STORAGE_ENGINE=1
    -DWITH_ARCHIVE_STORAGE_ENGINE=1 -DMYSQL_DATADIR=/data/mysqldata/ -DSYSCONFDIR=/app/soft/mysql/
    -DWITH_SSL=bundled -DENABLED_LOCAL_INFILE=1 -DWITH_INNOBASE_STORAGE_ENGINE=1
    -DWITH_BLACKHOLE_STORAGE_ENGINE=1 -DENABLE_DOWNLOADS=1
sudo make && make install

初始化数据库
  # cd /app/soft/mysql/
  # ./scripts/mysql_install_db --user=mysql --ldata=/data/mysqldata

