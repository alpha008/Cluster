#/bin/sh
execpath=$(cd "$(dirname "$0")"; pwd)
echo "current executed path is : ${execpath}"
cd ${execpath}
dbpath1=dbpath1
dbpath2=dbpath2
dbpath3=dbpath3
# 这里的-f参数判断$myFile是否存在
if [ ! -d "$dbpath1" ]; then
    mkdir -p $dbpath1
fi
if [ ! -d "$dbpath2" ]; then
    mkdir -p $dbpath2
fi
if [ ! -d "$dbpath3" ]; then
    mkdir -p $dbpath3
fi
echo "status"
netstat -ano | grep mongodb
mongod --dbpath=${execpath}/$dbpath1  --port 27017 --bind_ip=0.0.0.0 &
mongod --dbpath=${execpath}/$dbpath2  --port 27018 --bind_ip=0.0.0.0 &
mongod --dbpath=${execpath}/$dbpath3  --port 27019 --bind_ip=0.0.0.0 &
echo "status"
netstat -ano | grep mongodb




