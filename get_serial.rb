#!/usr/bin/env ruby
require "serialport"
 
port_str = "/dev/ttyUSB0"  
baud_rate = 9600
data_bits = 8
stop_bits = 1
parity = SerialPort::NONE
 
sp = SerialPort.new(port_str, baud_rate, data_bits, stop_bits, parity)

series=[]

while true 
 currents=sp.gets
 a,b =  currents.split
 if a == b 
  series << a.to_f	
 end
 series.each {|s| print "#{s}," }
 puts
end

sleep 1

sp.close                       
