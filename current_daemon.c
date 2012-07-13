#include <sys/types.h>
#include <stdlib.h>
#include <iostream>
#include <time.h>
#include <stdio.h> 
#include <string.h>
#include <unistd.h>
#include <fcntl.h> 
#include <errno.h> 
#include <termios.h>
#include <time.h>   

using namespace std;
#define FRESH_THRESHHOLD 1500
//#define TEST 1

char *buffer,*bufptr;
FILE *input;

#ifdef __linux__
//arduino millis() like
unsigned long millis(){
	struct timespec ts;
	clock_gettime(CLOCK_REALTIME, &ts);
	return((unsigned long)(ts.tv_sec * 1000.0 + (ts.tv_nsec/1000000.0)));
}	
#endif

void notify() {
	int rc=system("/bin/bash ./notify.sh");
	if(rc !=0){
		std::cout << "system returned " << rc << endl;
	}
}

void tweet(const char *what) {
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
	int rc=system(tweet_str);
	if(rc !=0){
		std::cout << "system returned " << rc;
	}
}

FILE *open_serial_port(){
#ifdef TEST 
	input = fopen("./testsamples.txt", "r");
#else
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
#endif
	return input;
}

int sample(FILE *input) {
	char buff[21]; 
	int a=0,b=0;
	char *pb;
#ifdef TEST
	usleep(1000); 
#endif
	while(1){
		char* rc=fgets(buff,20,input);
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
	int	heating=0;
	unsigned long start_heat;
	struct timespec ts;

	input = open_serial_port();

	while(1) {
		current = sample(input);
		if(current >= 1){  
			if(heating == 0 ){
				start_heat = millis();
				std::cout << "Rising " << start_heat << std::endl;
				fflush(stdout);
			}
			else
			{
				std::cout << "Heating "  << millis() << " " << (millis()-start_heat) << std::endl ;
			}
			heating++;
		}
		if(current < 1){
			if(heating >= 1){
				std::cout << "Falling " << millis() << " " << (millis()-start_heat) << std::endl  ;
				fflush(stdout);
				if(heating > FRESH_THRESHHOLD){
					notify();
				}
				heating=0;
			}
		}

	}
	fclose(input);
	return 0;
}



