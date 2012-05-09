#streamer  -c /dev/video0 -b 16 -o pot.jpeg
#s3cmd put --acl-public pot.jpeg  s3://coffee_pot/pot.jpeg
cat pot.sh | mutt -s "Email from Coffee Pot"   -- george@georgeredinger.com 
d=`date`
twurl -d 'status=$d' /1/statuses/update.xml

