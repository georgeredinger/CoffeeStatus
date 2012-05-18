require "serialport"
require "iconv"

def init
	port_str = "/dev/ttyUSB0"  
	baud_rate = 9600
	data_bits = 8
	stop_bits = 1
	parity = SerialPort::NONE
	@rising_edge=0;
	@start_brew=0
	@finish_brew=0
	if ARGV.length > 0
		@sp = File.open(ARGV[0],"r")
		@test=true
	else
		@sp = SerialPort.new(port_str, baud_rate, data_bits, stop_bits, parity)
		@test=false
	end 
end

def tweet(what)
	if @test
		puts "#{what}"
	else
		`twurl -d "status=#{what}" /1/statuses/update.xml`
	end
end

def sample
	if @test
		line=@sp.gets.split
		return [line[0].to_f,line[1].to_f] 
	end

	while true 
		line=@sp.gets
		unless line.nil?
			ic = Iconv.new('UTF-8//IGNORE', 'UTF-8')
			currents = ic.iconv(line)
			a,b =  currents.split
			if a == b 
				return [Time.now.to_f,a.to_f]
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
		if current[1] > 0.5 
			if heating == 0 
				puts "#{current[0]} #{heating}"
			end
			heating+=1
			rising_edge = true
			falling_edge = false
		end
		if current[1] < 0.25
			if heating >=1
				falling_edge=true
				rising_edge=false
				puts "#{current[0]} #{heating}"
				if heating > 500
					tweet("#{Time.now} Fresh Pot")
				end
				heating=0
			end
		end
	end
end



#loop till exception?
init
main

@sp.close                       

