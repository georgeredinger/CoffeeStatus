#!/bin/bash
while true
do 
  sensors | grep temp | gawk 'BEGIN{FS=" "}{printf "%d %d\n",systime(),($2+0)*1.8+32}' >> temperature.log
  sleep 60
done

