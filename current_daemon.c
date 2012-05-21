#include <stdio.h> // standard input / output functions
#include <string.h> // string function definitions
#include <unistd.h> // UNIX standard function definitions
#include <fcntl.h> // File control definitions
#include <errno.h> // Error number definitions
#include <termios.h> // POSIX terminal control definitionss
#include <time.h>   // time calls

char *buffer,*bufptr;
FILE *input;

void tweet(char *what) {
	char tweet_str[141+50];
	time_t rawtime;
	struct tm * timeinfo;

	time ( &rawtime );
	timeinfo = localtime ( &rawtime );
	char *timestamp=asctime (timeinfo) ;
	timestamp[strlen(timestamp)-1]='\0';

	sprintf(tweet_str,
		"twurl -d \"status=%s %s\" /1/statuses/update.xml > /dev/null",
			timestamp, what);
	system(tweet_str);
}

FILE *open_serial_port(){
	int fd;
	FILE *input;
	struct termios termattr;
	speed_t baudRate;
	input = fopen("/dev/ttyUSB0", "r");
	fd = fileno(input);
	tcgetattr(fd, &termattr);
	baudRate = cfgetispeed(&termattr);
	if (baudRate != B9600) {
		cfsetispeed(&termattr, B9600);
		tcsetattr(fd, TCSANOW, &termattr);
	}
	return input;
}

int sample(FILE *input) {
	char buff[21]; 
	char bstr[10];
	int a,b;
	char *pb;
	while(1){
		fgets(buff,20,input);
		a=atoi(buff);
		pb = strchr(buff,' ');
		if(pb != NULL) {
			b=atoi(pb);
		}
		if(a == b) {
			return a;
		}
		usleep(1000); //prevent 100% cpu usage on gets fail
	}
}


int main() {
	int current;
	int	rising_edge=0;
	int	falling_edge=0;
	int	heating=0;
	input = open_serial_port();
	while(1) {
		current = sample(input);
		if(current >= 1){  
			if(heating == 0 ){
				printf("%d %d\n", current,heating);
			}
			heating++;
			rising_edge = 1;
			falling_edge = 0;
		}
		if(current < 1){
			if(heating >=1){
				falling_edge=1;
				rising_edge=0;
				printf("%d %d\n", current, heating);
				if(heating > 500){
					tweet("Fresh Pot");
				}
				heating=0;
			}
		}

	}
	fclose(input);
	return 0;
}



