set yrange [-0.05:0.05]
set xdata time
set timefmt "%s"
#plot "current_derivitive.log" using 1:2 with lines smooth bezier
plot "current_derivitive.log" using 1:2 with lines 
pause 100 

