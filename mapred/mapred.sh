#!/bin/bash

# ÷¥––HadoopΩ¯––‘§¥¶¿Ì
#°“ªπ≤£≥∏ˆ≤Ω÷Ë
# 1:  ˝æ›‘¥£(ubs»’÷æ) -> uniq £®»°≥ˆquery cookie≤¢»•÷ÿ£©
# 2: uniq -> filtered (π˝¬À÷ª±ª1∏ˆcookie∑√Œ µƒquery)
# 3: filtered -> result (∞¥’’cookieæ€ºØ)

source ../common.sh
source ../conf.sh

$HADOOP/bin/hadoop dfs -rmr $UNIQ_DATA_PATH
$HADOOP/bin/hadoop jar $HADOOP/contrib/streaming/hadoop-streaming-1.0.1.jar \
    -D mapred.job.map.capacity=$MAP_CAP \
    -D mapred.job.reduce.capacity=$REDUCE_CAP \
    -mapper 'python mapper.py' \
    -reducer 'python reducer.py' \
    -input $RAW_DATA_PATH \
    -output $UNIQ_DATA_PATH \
	-numReduceTasks $REDUCE_NUM \
    -file mapper.py \
	-file reducer.py
if [ $? -ne 0 ];
then
    write_log "failed do mapreduce job: raw-data to uniq-data"
    exit 1
fi


