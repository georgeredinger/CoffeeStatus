

void setup() {
  // initialize serial communications at 9600 bps:
  Serial.begin(9600); 
}



void loop() {
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
   Serial.print(i);
   Serial.print(" "); 
   Serial.println(accumulator*400.0);
   delay(1000);
}
