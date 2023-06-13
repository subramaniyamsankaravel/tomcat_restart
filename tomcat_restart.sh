#!/bin/sh

process_PID=`ps -fe |grep "<path_of_tomcat>" | grep -v grep | awk '{print $2}'`

if test -e <path_of_tomcat>/tomcat/bin/shutdown.sh ; then (cd <path_of_tomcat>/tomcat/bin ; ./shutdown.sh;) fi

process_RUNNING=$(ps --no-headers -p $process_PID | wc -l)				
COUNTER_CURRENT=0
COUNTER_MAX_LOOP=10
SLEEP_TIME=2
while [ "$process_RUNNING" -gt 0 -a "$COUNTER_CURRENT" -lt "$COUNTER_MAX_LOOP" ]
do  
  echo -n "."
  sleep $SLEEP_TIME  
  let "COUNTER_CURRENT=$COUNTER_CURRENT+1"
  dgwv2_dev_RUNNING=$(ps --no-headers -p $process_PID | wc -l)
done
echo ""
if [ "$process_RUNNING" -gt 0 ]; then
	echo "You should Force kill Tomcat !"
	echo "kill -9 $process_PID"
fi
# wait 2 extra sec to ensure resources are free up
#sleep 2
echo 'Shutdown done, Starting Dgwv2 Tomcat'
cd <path_of_tomcat>/tomcat/webapps ; rm -rf <extracted folder>/ 
cd <path_of_tomcat>/tomcat/bin; ./startup.sh 
