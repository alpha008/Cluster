#/bin/sh
execpath=$(cd "$(dirname "$0")"; pwd)
echo "current executed path is : ${execpath}"
cd ${execpath}
killname=mysql
echo "before status"
ps -elf | grep ${killname} | grep -v grep
echo "before status"
PROCESS=`ps -ef|grep ${killname} | grep -v grep | grep -v PPID|awk '{print $2}'`
for i in $PROCESS
do
    echo "Kill the  process [ ${killname} ]"
    sudo kill -9 ${i}
done
echo "after status"
ps -elf | grep ${killname} | grep -v grep
echo "after status"

#ps -ef|grep mongo | grep -v grep | grep -v PPID|awk '{print $3}


