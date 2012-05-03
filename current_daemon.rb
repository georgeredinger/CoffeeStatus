require "serialport"
 
port_str = "/dev/ttyUSB0"  
baud_rate = 9600
data_bits = 8
stop_bits = 1
parity = SerialPort::NONE
 
def initialize
  @sp = SerialPort.new(port_str, baud_rate, data_bits, stop_bits, parity)
end

def sample
  loop 
  	currents=sp.gets
  	unless currents.nil?
  	  a,b =  currents.split
  	  if a == b 
  	  	 return a
  	  end
  	end
  end
end


def main
 rising_edge=0
 if sample > 0.5 

 end
end

main


@sp.close                       
