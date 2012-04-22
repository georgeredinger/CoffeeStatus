#!/usr/bin/env ruby 
# encoding: UTF-8
require "serialport"
 
port_str = "/dev/ttyUSB0"  
baud_rate = 9600
data_bits = 8
stop_bits = 1
parity = SerialPort::NONE
 
ticks=%W(▁ ▂ ▃ ▄ ▅ ▆ ▇ █)

sp = SerialPort.new(port_str, baud_rate, data_bits, stop_bits, parity)

series=[]
done=false
until done  
	currents=sp.gets
	#puts currents
	unless currents.nil?
	  a,b =  currents.split
	  if a == b 
	  	c = a.to_f
			index = (c*5).to_i
	  	print ticks[index]  
	  end
	end
	sleep(60)
end

sp.close                       
