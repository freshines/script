#!/bin/bash
# 执行创建index的过程

source ./common.sh
source ./conf.sh

WD=`pwd`
PART_PATH=$WD/data-parts

write_log "start to build index, pwd=$WD"

# 1. 执行hadoop任务
cd mapred; bash mapred.sh
if [ $? -ne 0 ]; then
    write_log "mapreduce job failed, exit"
    exit 1
fi
write_log "mapreduce job finished."
cd $WD

# 2. 将结果复制到本地
write_log "fetching mapreduce output data"
if [ -e $PART_PATH ]; then
    write_log "rm $PART_PATH"
    rm -rf $PART_PATH
fi

$HADOOP dfs -copyToLocal $RESULT_DATA_PATH $PART_PATH
if [ $? -ne 0 ]; then
    write_log "failed fetch mapreduce output data"
    $ALARM "failed fetch mapreduce output data"
    exit 1
fi
write_log "data fetched"

# 3. 执行create-index程序以创建索引
cd ../bin
./create-index $PART_PATH $REDUCE_NUM
if [ $? -ne 0 ]; then
    write_log "create-index failed, halt"
    exit 1
fi

# 4. 将结果mv到../dict
rm -rf ../dict
mkdir ../dict
mv {*.dat,csign2coffset.*} ../dict
if [ $? -ne 0 ]; then
    write_log "mv result to ../dict failed"
    exit 1
fi

