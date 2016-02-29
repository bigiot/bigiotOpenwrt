#!/bin/ash
shPath=$(cd `dirname $0`; pwd)
curl -o ${shPath}/ip.txt http://members.3322.org/dyndns/getip
myip=$(cat ${shPath}/ip.txt)
myOldIp=$(cat ${shPath}/oldIp.txt)
if [ $3 ]
then
param3=$3
else
param3=80
fi
if [ ${myip} != ${myOldIp} ]
then
curl -o ${shPath}/status.txt http://www.bigiot.net/Dns/updateDns?id=$1\&ip=${myip}\&pw=$2\&pt=${param3}
status=$(cat ${shPath}/status.txt)
cp -f ${shPath}/ip.txt ${shPath}/oldIp.txt
echo ${status}
fi
