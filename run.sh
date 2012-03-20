#!/bin/bash
# ִ�д���index�Ĺ���

source ./common.sh
source ./conf.sh

WD=`pwd`
PART_PATH=$WD/data-parts

write_log "start to build index, pwd=$WD"

# 1. ִ��hadoop����
cd mapred; bash mapred.sh
if [ $? -ne 0 ]; then
    write_log "mapreduce job failed, exit"
    exit 1
fi
write_log "mapreduce job finished."
cd $WD

# 2. ��������Ƶ�����
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

# 3. ִ��create-index�����Դ�������
cd ../bin
./create-index $PART_PATH $REDUCE_NUM
if [ $? -ne 0 ]; then
    write_log "create-index failed, halt"
    exit 1
fi

# 4. �����mv��../dict
rm -rf ../dict
mkdir ../dict
mv {*.dat,csign2coffset.*} ../dict
if [ $? -ne 0 ]; then
    write_log "mv result to ../dict failed"
    exit 1
fi

