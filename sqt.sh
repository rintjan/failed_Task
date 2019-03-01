#!/bin/bash

hdfs dfs -get /user/cloudera/STEP1/in/input.csv
sed -e '1,2d;$d' input.csv | sed '$d' > test.csv
rm input.csv
count=$(< "test.csv" wc -l)
echo "Line count is $count" >> test.csv
hdfs dfs -put -f test.csv /user/cloudera/STEP2/YYYY/MM/DD
hdfs dfs -test -e /user/cloudera/STEP2/YYYY/MM/DD/SUCCESS

retval=$?
if [ "$retval"==0 ]; then
	echo "IT IS THERE"
else
	hdfs dfs -touchz /user/cloudera/STEP2/YYYY/MM/DD/SUCCESS
fi
