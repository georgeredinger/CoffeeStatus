set yrange [0:2]
set xdata time
set timefmt "%s"
set format x "%M" 
#plot "current.log" using 1:2 with lines smooth csplines
#plot "pot.log" using 1:2 with lines 
plot "pot.log" using 1:2 with histeps
pause 100 

