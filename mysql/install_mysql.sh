#/bin/sh
execpath=$(cd "$(dirname "$0")"; pwd)
echo "current executed path is : ${execpath}"
sudo apt-get install mysql-server-5.7
