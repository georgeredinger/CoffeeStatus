#!/bin/bash
stty -F /dev/ttyUSB0 ispeed 9600 ospeed 9600 cs8 -ignpar -cstopb -echo

while true
do
	 READ=`dd if=/dev/ttyUSB0 count=12 2>/dev/null`
	   echo $READ
	done
done
