#/bin/sh
execpath=$(cd "$(dirname "$0")"; pwd)
echo "current executed path is : ${execpath}"
#source /home/alpha/shelltest/config.ini 直接导配置文件可能会方便一点 这里我就不改了
#!/bin/bash
#source /home/alpha/shelltest/config.ini 直接导配置文件可能会方便一点 这里我就不改了
cat $1 | while read line
do
      #master side
      masterIp=$(echo $line |awk '{print $1}') #master ip地址
      masterSqlname=$(echo $line |awk '{print $2}') #master数据库用户名
      masterSqlpass=$(echo $line |awk '{print $3}') #master数据库密码
      slaveName=$(echo $line |awk '{print $4}') #master授权给slave远程登录master数据库的用户名
      slavePass=$(echo $line |awk '{print $5}') #slave 登录master时的密码
      slaveIp=$(echo $line |awk '{print $6}') #slave ip地址
      slaveSqlname=$(echo $line |awk '{print $7}') #slave 数据库用户名
      slaveSqlpass=$(echo $line |awk '{print $8}') #slave 数据库密码
      port=$(echo $line |awk '{print $9}') #端口号

      echo ${line}
      echo

     #在数据库中给slave登录master数据库的权限
      grantCmd="grant replication slave on*.*to '${slaveName}'@'${slaveIp}' identified by '${slavePass}';"
      echo "grant cmd:" ${grantCmd}

    #在master的mysql数据库中执行grant操作
      remoteCmd="mysql -h${masterIp} -u${masterSqlname} -p${masterSqlpass} -e \"${grantCmd}\""
      echo "remote cmd:" ${remoteCmd}

      mysql -h${masterIp} -u${masterSqlname} -p${masterSqlpass} -e "${grantCmd}"

      if [ $? -eq 0 ]; then
          echo "exec: <grant replication slave...> success"
      else
          echo "exec: <grant replication slave...> failure"
          fi
      echo

     #查看master状态
      statusCmd="mysql -h${masterIp} -u${masterSqlname} -p${masterSqlpass} -e \"show master status;\""
      echo "status cmd:" ${statusCmd}
      mysql -h${masterIp} -u${masterSqlname} -p${masterSqlpass} -e "show master status;"
      if [ $? -eq 0 ]; then
          echo "exec: <show master status> success"
      else
          echo "exec: <show master status> failure"
      fi
      echo

     #查看master状态 获取file 以及position的信息
      bininfo=$(mysql -h${masterIp} -u${masterSqlname} -p${masterSqlpass} -e "show master status;")
      file=$(echo $bininfo | awk '{print $5}')
      pos=$(echo $bininfo | awk '{print $6}')

      echo "bininfo:" $bininfo
      echo "file name:" $file
      echo "position:" $pos

     #查看master中mysql的登录账户信息
      queryCmd="mysql -h${masterIp} -u${masterSqlname} -p${masterSqlpass} -e \"select Host, User, Password from mysql.user;\""
      echo "query cmd:" ${queryCmd}
      mysql -h${masterIp} -u${masterSqlname} -p${masterSqlpass} -e "select Host, User, Password from mysql.user;"
      if [ $? -eq 0 ]; then
          echo "exec: <select *from mysql.user> success"
      else
          echo "exec: <select *from mysql.user> failure"
      fi

      #slave side
      #首先确保slave中的mysql 停止slave 
      startCmd="mysql -h${slaveIp} -u${slaveSqlname} -p${slaveSqlpass} -e \"slave stop;\""
      echo "start cmd:"${startCmd}
      mysql -h${slaveIp} -u${slaveSqlname} -p${slaveSqlpass} -e "slave stop;"
      if [ $? -eq 0 ]; then
          echo "exec: <slave stop> success"
          echo
      else
          echo "exec: <slave stop> failure"
          echo
      fi

     #change master
      changeCmd="change master to MASTER_HOST='${masterIp}',MASTER_PORT=${port},MASTER_USER='${slaveName}',MASTER_PASSWORD='${slavePass}',MASTER_LOG_FILE='${file}',MASTER_LOG_POS=${pos};"
      echo "change cmd:" ${changeCmd}

    #登录slave的mysql进行 change操作
      remoteCmd="mysql -h${slaveIp} -u${slaveSqlname} -p${slaveSqlpass} -e \"${changeCmd}\""
      echo "remote cmd:" ${remoteCmd}
      mysql -h${slaveIp} -u${slaveSqlname} -p${slaveSqlpass} -e "${changeCmd}"
      if [ $? -eq 0 ]; then
        echo "exec: <change master...> success"
        echo
      else
          echo "exec: <change master...> failure"
          echo
      fi
      echo

     #启动slave
      startcmd="mysql -h${slaveIp} -u${slaveSqlname} -p${slaveSqlpass} -e \"slave start;\""
      echo "start cmd:" ${startcmd}
      mysql -h${slaveIp} -u${slaveSqlname} -p${slaveSqlpass} -e "slave start;"
      if [ $? -eq 0 ]; then
          echo "exec: <slave start> success"
          echo
      else
          echo "exec: <slave start> failure"
          echo
      fi

     #查看slave状态
      statusCmd="mysql -h${slaveIp} -u${slaveSqlname} -p${slaveSqlpass} -e \"show slave status\G\""
      echo "status cmd:" ${statusCmd}
      mysql -h${slaveIp} -u${slaveSqlname} -p${slaveSqlpass} -e "show slave status\G"
      if [ $? -eq 0 ]; then
          echo "exec: <show slave status> success"
          echo
      else
          echo "exec: <show slave status> failure"
          echo
      fi

done







