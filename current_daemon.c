#include <stdio.h> // standard input / output functions
#include <string.h> // string function definitions
#include <unistd.h> // UNIX standard function definitions
#include <fcntl.h> // File control definitions
#include <errno.h> // Error number definitions
#include <termios.h> // POSIX terminal control definitionss
#include <time.h>   // time calls

FILE *input;
char buff[21],*buffer,*bufptr;
int fd;

int main() {
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
	while(1) {
		fgets(buff,20,input);
		printf ("%s",buff);
	}
	fclose(input);
	return 0;
}



