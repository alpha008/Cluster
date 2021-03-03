#/bin/sh
execpath=$(cd "$(dirname "$0")"; pwd)
echo "current executed path is : ${execpath}"

file_mongo_src="mongo_source"
file_mongo_tgz="mongodb-shell-linux-x86_64-ubuntu1804-4.4.4.tgz"
file_mongo="mongodb-shell-linux-x86_64-ubuntu1804-4.4.4"
if [ ! -d "$file_mongo_src" ]; then
    echo ''${file_mongo_src}' is not exist'
    mkdir -p ${file_mongo_src}
    cd ${file_mongo_src}
    wget https://fastdl.mongodb.org/linux/mongodb-shell-linux-x86_64-ubuntu1804-4.4.4.tgz
    echo 'download '${file_mongo_tgz}' sucess'
    tar -xvf ${file_mongo_tgz}
    sudo mv ${file_mongo} /usr/local/mongodb
    #vim /etc/profile  # 添加环境变量
    #在/etc/profile 最后一行，添加 export PATH=/usr/local/mongodb/bin:$PATH
    #source /etc/profile
    sudo sed -i '$a\export PATH=/usr/local/mongodb/bin:$PATH'  /etc/profile
    sudo cat /etc/profile
    source /etc/profile
    cd ${execpath}
    echo "------------------------"
    echo ${execpath}
fi
## https://fastdl.mongodb.org/linux/mongodb-shell-linux-x86_64-ubuntu1804-4.4.4.tgz
#  wget https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-ubuntu1804-4.4.0-rc8.tgz







