set yrange [0:1]
set xdata time
set timefmt "%s"
#plot "current.log" using 1:2 with lines smooth bezier
plot "current.log" using 1:2 with lines 
pause 100 
