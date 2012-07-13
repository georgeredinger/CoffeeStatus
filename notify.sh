#!/bin/bash
d=`date`
twurl -d "status=$d Fresh Pot" /1/statuses/update.xml > /dev/null
mpg123 bell.mp3

