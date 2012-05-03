#!/bin/bash
awk -f derivitive.awk < pot.log > pot_derivitive.log
gnuplot < plot_derivitive.gnu    
