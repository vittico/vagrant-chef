#!/bin/bash
# description: Tomcat Start Stop Restart Status
# processname: tomcat
# chkconfig: 234 20 80
 
CATALINA_HOME=/opt/tomcat8
 
case $1 in
start)
sh $CATALINA_HOME/bin/startup.sh
;;
stop)
sh $CATALINA_HOME/bin/shutdown.sh
;;
restart)
sh $CATALINA_HOME/bin/shutdown.sh
sh $CATALINA_HOME/bin/startup.sh
;;
status)
ps -ef | grep tomcat
esac
exit 0
