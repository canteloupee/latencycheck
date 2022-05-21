#!/bin/bash

if ["$1" == ""] 2> /dev/null
then
  echo "Please enter a subnet, from email and to email"
  echo "Syntax: latencycheck 192.168.1.0/24 example@example.com test@example.com"

else
echo "Please wait while your report is generated"
sleep 3
fping -C 1 -g $1 > results.txt 2> /dev/null;
awk '{if($6>50)print$0}' < results.txt > highpings.txt;
from=$2
to=$3
subject="High Ping Report"
body="Please see the attached report"
mail -s "$subject" -r "$from" "$to" <<< "$body" -A highpings.txt 2> /dev/null; 
fi

exit 0;
