def low_pass(input,filtered_input,filter_constant)
	input*(1-filter_constant)+filtered_input*filter_constant
end

filtered=0.0
STDIN.each_line do |line|
	time_stamp,sample = line.split
  filtered = low_pass(sample.to_f,filtered,0.995)
	puts  "#{time_stamp} #{filtered}"
end
