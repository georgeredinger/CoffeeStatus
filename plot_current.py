#!/usr/bin/env python
import numpy as np
from matplotlib import pyplot as plt
from matplotlib import dates
import datetime

#import Gnuplot
import serial
import sys
import time
import array

ser = serial.Serial('/dev/ttyUSB0', 9600)

plt.interactive( True )
readings = []
fig = plt.figure()
plt.xlim(0,1)
plt.ylim(0,1)
plt.xlabel('x')
plt.title('test')

#g = Gnuplot.Gnuplot()
#g.title("Nerdlandia Coffee Pot")
#g('set style  data lines')
#g('set yrange [0:2]')
#g('set timefmt "%s"')
#g('set xtics 3600')
#g('set xdata time')
#g('plot "data" using 1:2')

while 1:
  ssample = ser.readline().split()[0]
  sample = float(ssample)
  timestamp = float(time.time())
  print "%f %f" % (timestamp, sample)

  reading = [timestamp,sample]
  
  readings.append(reading)
  
  if len(readings) > 60*60:
    readings = readings[-10:]
  
#  g.plot(readings)
  plt.plot(readings)
  fig.canvas.draw()




