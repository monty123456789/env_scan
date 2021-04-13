


#include <Servo.h>

int pos;
int pot;

Servo servo_9;
Servo servo_8;

boolean debugToSerial = true;


long duration;
int distance;

#include <SoftwareSerial.h>  

//SoftwareSerial port(1, 0);
SoftwareSerial portOne(10, 11);


//This is the only code I could find that would make the lidar sensor work. 
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



void setup()
{
  servo_9.attach(9, 500, 2500);
  servo_8.attach(8, 500, 2500);

  
  //pinMode(13, OUTPUT);
  Serial.begin(115200);
  portOne.begin(115200);
}

void loop()
{
  
 //all of this is form the internet, I would love to understand it but don't. The scanner cannot be just plugged in.
   int distance1 = 0;
  int strength1 = 0;
  boolean receiveComplete1 = false;

  int distance2 = 0;
  int strength2 = 0;
  boolean receiveComplete2 = false;

  while(!receiveComplete1) {
    getTFminiData(&portOne, &distance1, &strength1, &receiveComplete1);
    if(receiveComplete1) {

      if(debugToSerial) {
      Serial.println(distance1);
      }
    }
  }
  receiveComplete1 = false;
  
  
  //there is an inner and outer loop for the servos, this is because every time the pan servo does one fullrotation, the inner servo should just iterate once. 
  for (pot = 45; pot <= 135; pot += 1) {
    servo_9.write(pot);

  for (pos = 45; pos <= 135; pos += 1) {
      
    servo_8.write(pos);
  
    delay(15); // Wait for 15 millisecond(s)

  
  int distance1 = 0;
  int strength1 = 0;
  boolean receiveComplete1 = false;

  int distance2 = 0;
  int strength2 = 0;
  boolean receiveComplete2 = false;

  while(!receiveComplete1) {
    getTFminiData(&portOne, &distance1, &strength1, &receiveComplete1);
    if(receiveComplete1) {

      if(debugToSerial) {
      Serial.println(distance1);
      }
    }
  }
  receiveComplete1 = false;
  delay(15); // Wait for 15 millisecond(s)





  
  
 
 //sends this number to processing after each rotation. 
  if (pos == 90) {
    if(debugToSerial) {
    Serial.println(1000.9);
  }
  }
 
  }
  }
  
  for (pot = 135; pot >= 45; pot -= 1) {
  servo_9.write(pot);

  for (pos = 135; pos >= 45; pos -= 1) {
  servo_8.write(pos);

  
  int distance1 = 0;
  int strength1 = 0;
  boolean receiveComplete1 = false;

  int distance2 = 0;
  int strength2 = 0;
  boolean receiveComplete2 = false;

  while(!receiveComplete1) {
    getTFminiData(&portOne, &distance1, &strength1, &receiveComplete1);
    if(receiveComplete1) {
      if(debugToSerial) {
      Serial.println(distance1);
      }
    }
  }
  receiveComplete1 = false;
  delay(15); // Wait for 15 millisecond(s)
  }
   
  }
   
}
