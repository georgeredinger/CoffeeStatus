#!/bin/bash
while true
do
  mem=`free | grep Mem: | awk '{print $3}'`
  d=`date +%s`
  echo "$d $mem" >> memory.log
  sleep 60s
done

