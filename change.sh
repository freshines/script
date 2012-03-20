#!/bin/bash
echo 'work00.egov.com' > /home/freshines/work/local/hadoop/conf/masters
echo -e 'work00.egov.com\nwork01.egov.com\nwork02.egov.com\nwork03.egov.com\nwork04.egov.com\nwork05.egov.com' > /home/freshines/work/local/hadoop/conf/slaves
sed -i 's/work00/work00.egov.com/g' /home/freshines/work/local/hadoop/conf/mapred-site.xml
sed -i 's/work00/work00.egov.com/g' /home/freshines/work/local/hadoop/conf/core-site.xml
