#!/bin/bash
awk -f derivitive.awk < current.log > current_derivitive.log
gnuplot < plot_derivitive.gnu    
