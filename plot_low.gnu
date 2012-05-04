set yrange [0.05:0.1]
set xdata time
set timefmt "%s"
set format x "%M" 
set grid
plot "pot_low.log" using 1:2 with lines 
pause 100 

