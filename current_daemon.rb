require "serialport"

def init
  port_str = "/dev/ttyUSB0"  
  baud_rate = 9600
  data_bits = 8
  stop_bits = 1
  parity = SerialPort::NONE

	@sp = SerialPort.new(port_str, baud_rate, data_bits, stop_bits, parity)
end

def sample
	while true 
	currents=@sp.gets
	unless currents.nil?
		a,b =  currents.split
		if a == b 
			return a.to_f
		end
	end
end
end

#TODO detect sample rate?
#assume 1 second for now
def main
	rising_edge=0
	heating=0
	while true
		current=sample
	  #puts "#{Time.now.to_i} #{current}"
		if current > 0.5 
			heating+=1
			riding_edge = true
			falling_edge = false
		end
		if current < 0.25
			if heating >=1
				falling_edge=true
				riding_edge=false
				puts "*#{Time.now.to_i} #{heating}"
				heating=0
			end
		end
	end
end



#loop till exception?
init
main

@sp.close                       

