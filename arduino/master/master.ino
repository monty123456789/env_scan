#include <Wire.h>

#include <SoftwareSerial.h>  

//SoftwareSerial port(TX, RX);
SoftwareSerial portOne(10, 11);

void setup() {
  Wire.begin();        // join i2c bus (address optional for master)
  Serial.begin(9600); 
 // Serial.begin(115200);
  portOne.begin(115200);// start serial for output
}

void loop() {
  Wire.requestFrom(8, 2);    // request 6 bytes from slave device #8

  while (Wire.available()) { 
    //Serial.print("g");
    // slave may send less than requested
    int c = Wire.read(); // receive a byte as character
     //Serial.print(c); 
    
    if (c == 01) {
       Serial.println(1000.90);

    } else if (c == 10) {
      scanner();
    } 
// print the character
  }

  delay(40);
}



void getTFminiData(SoftwareSerial* port, int* distance, int* strength, boolean* complete) {
  static char i = 0;
  char j = 0;
  int checksum = 0; 
  static int rx[9];

  port->listen();
  if(port->available()) {  
    rx[i] = port->read();
    if(rx[0] != 0x59) {
      i = 0;
    } else if(i == 1 && rx[1] != 0x59) {
      i = 0;
    } else if(i == 8) {
      for(j = 0; j < 8; j++) {
        checksum += rx[j];
      }
      if(rx[8] == (checksum % 256)) {
        *distance = rx[2] + rx[3] * 256;
        *strength = rx[4] + rx[5] * 256;
        *complete = true;
      }
      i = 0;
    } else {
      i++;
    } 
  }  
  
}


void scanner() {
   int distance1 = 0;
  int strength1 = 0;
  boolean receiveComplete1 = false;

  int distance2 = 0;
  int strength2 = 0;
  boolean receiveComplete2 = false;

  while(!receiveComplete1) {
    getTFminiData(&portOne, &distance1, &strength1, &receiveComplete1);
    if(receiveComplete1) {
      Serial.println(distance1);
      
    }
  }
  receiveComplete1 = false;
 
}
