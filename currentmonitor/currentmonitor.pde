

void setup() {
  // initialize serial communications at 9600 bps:
  Serial.begin(9600); 
}

float sample(){
   int i = 0;                        // declare and initialize counter
   double accumulator = 0.0;    // accumulator variable to store samples
   double sample;
   unsigned long start = micros();
   while (micros()<  start + 16667){
     sample= analogRead(A0)-511;
     accumulator = accumulator + sq(sample) ;  // read A/D pin
     i++;
   }
   accumulator = sqrt(accumulator) / i;
   return accumulator;
}



void loop() {
   double samp;
   double acc=0.0;
   for(int i=0; i < 60;i++) {
        acc += sample();
   }
   acc /= 60.0;
   Serial.print(acc);
   Serial.print(" ");
   Serial.println(acc);
   delay(1000);
}

