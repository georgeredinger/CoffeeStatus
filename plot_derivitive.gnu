set xdata time
set timefmt "%s"
plot "current_derivitive.log" using 1:2 with lines smooth bezier
pause 100 

