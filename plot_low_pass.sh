#!/bin/bash
ruby lowpass.rb < pot.log > pot_low.log ; gnuplot < plot_low.gnu 

