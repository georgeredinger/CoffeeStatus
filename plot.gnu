set xdata time
set timefmt "%s"
plot "current.log" using 1:2 with lines smooth bezier
pause 100 

