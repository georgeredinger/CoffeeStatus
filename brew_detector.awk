#! /bin/awk -f
BEGIN { 
	rising_edge=0;
	start_brew=0
	finish_brew=0
}

$0 !~ /^#/ { 
	if ($2 > 1.0) {
		if(rising_edge == 0){
    	start_brew = $1;
	  }
		rising_edge++;
		if(rising_edge == 5){
	   	printf "Start Brew %s\n", strftime("%c",start_brew);
	  }
  }
	else
	{
		if(rising_edge > 4){
			finish_brew=$1
	   	printf "Finish Brew %s\n", strftime("%c",finish_brew);
		}
		rising_edge=0;
	}
}
