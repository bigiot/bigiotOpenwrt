#!/bin/ash
: '
贝壳物联DNS网关动态更新ip地址脚本
由网友 hzl88688 最新修改
贝壳物联 www.bigiot.net
'
shPath=$(cd `dirname $0`; pwd)
ip_regex="[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}"
myip=$(echo $( wget -O -  http://ddns.nat123.com 2>/dev/null) | grep -o "$ip_regex")
myOldIp=$(cat ${shPath}/oldIp.txt)
if [ $3 ]
then
param3=$3
else
param3=80
fi
if [ ${myip} != ${myOldIp} ]
then
wget -O ${shPath}/status.txt http://www.bigiot.net/Dns/updateDns?id=$1\&ip=${myip}\&pw=$2\&pt=${param3}
status=$(cat ${shPath}/status.txt)
echo $myip > ${shPath}/oldIp.txt
echo ${status}
fi
