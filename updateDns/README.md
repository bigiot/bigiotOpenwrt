##简介

此脚本可作为动态域名解析的替代方案，在无法实现动态域名解析时，可用此脚本实时将动态外网IP地址绑定至固定网址（URL），实现通过同一地址（URL）访问固定设备。

##使用条件

* 1、设备可运行shell命令；
* 2、与外网连接，且可直接通过ip地址访问；

##使用方法

* 1、登录 http://www.bigiot.net 注册申请一个固定URL地址；
* 2、将本文件夹上传至设备，并定时运行updateDns.sh脚本。

参考如下crontab命令行：

* `*/20 * * * * /home/updateDns.sh 1 ddfd8XXXX 80`
* `*/20 * * * * `表示20分钟执行一次脚本；
* `/home/updateDns.sh` 为脚本位置；
* `1` Dns网关ID 必填
* `ddfd8XXXX` Dns网关密码 必填
* `80` 绑定的端口 默认为80 可选

##文件说明

*    `oldIp.txt` 最近一次ip地址
*    `status.txt` 更新状态，可查看此文件了解脚本执行情况
*    `updateDns.sh` 执行更新脚本
*    `README.md` 本文件
   
##脚本信息
 *  版本：v1.1
 *  作者：www.bigiot.net
 *  时间：2016.3.6
