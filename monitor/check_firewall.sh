#!/bin/bash
# author: testerzhang

centos_version=`cat /etc/redhat-release|sed -r 's/.* ([0-9]+)\..*/\1/'`
firewall_open=0

if [ "$centos_version" -eq 6 ]
then
   echo "system: CentOS 6"
   check_result=`service iptables status|grep "not running"|wc -l`
   if [ "$check_result" -eq 0 ]
   then
      echo "防火墙处于开启状态"
      firewall_open=1
   fi
elif [ "$centos_version" -eq 7 ]
then
   echo "system: CentOS 7"

   check_result=`/sbin/iptables -L -n|grep "0.0.0.0"|wc -l`
   if [ "$check_result" -gt 0 ]
   then
      echo "防火墙处于开启状态"
      firewall_open=1
   fi
else
   echo "不支持检测其他CentOS系统版本"
fi

if [ "$firewall_open" -eq 0 ]
then
   echo "警告:系统未开启未开启防火墙"
   # 下面可以写你的告警策略发送通知,或是直接开启防火墙
fi

