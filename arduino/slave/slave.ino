
#include <Servo.h>


#include <Wire.h>


int pos;
int pot;

int r;

Servo servo_9;
Servo servo_8;



long duration;
int distance;


int trigPin = 3; //sends
int echoPin = 2;  //recieves

void setup() {

  servo_9.attach(9, 500, 2500);
  servo_8.attach(8, 500, 2500);

  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);
  pinMode(13, OUTPUT);
  Serial.begin(9600);
  
  Wire.begin(8);                // join i2c bus with address #8
  Wire.onRequest(requestEvent); // register event
}

void loop() {
  
 // delay(15);
  for (pot = 85; pot >= 40; pot -= 1) {
  servo_9.write(pot);
   //Serial.print( "outer +" + pot);
  for (pos = 80; pos >= 35; pos -= 1) {
   // sensor();
    servo_8.write(pos);
     
    //Wire.write(pos);
    //requestEvent();
    delay(40);
  }
  }

// for (pot = 0; pot <= 90; pot += 1) {
//  servo_9.write(pot);
//  for (pos = 90; pos >= 0; pos -= 1) {
//    //sensor();
//    servo_8.write(pos);
//     //Wire.write(pos);
//   
//    //requestEvent();
//    delay(15);
//  }
// }
  
}

// function that executes whenever data is requested by master
// this function is registered as an event, see setup()
void requestEvent() {
 if (pos != 35) {
     Wire.write(10);
  } else if  (pos == 35) {
      Wire.write(01);
  }
    
  // respond with message of 6 bytes
  // as expected by master
}
