#!/usr/bin/env ruby
require "serialport"
 
port_str = "/dev/ttyUSB0"  
baud_rate = 9600
data_bits = 8
stop_bits = 1
parity = SerialPort::NONE
 
sp = SerialPort.new(port_str, baud_rate, data_bits, stop_bits, parity)

series=[]
done=false
until done  
 currents=sp.gets
 a,b =  currents.split
 if a == b 
	 puts "#{Time.now.to_i} #{a.to_f}"
	 done = true
 end
end


sp.close                       
