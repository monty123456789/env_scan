
#include <Servo.h>

int pos;
int pot;

Servo servo_9;
Servo servo_8;



long duration;
int distance;

int trigPin = 3; //sends
int echoPin = 2;  //recieves

void setup()
{
  servo_9.attach(9, 500, 2500);
  servo_8.attach(8, 500, 2500);

  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);
  pinMode(13, OUTPUT);
  Serial.begin(9600);

  Serial.begin(9600);
  Serial.println("Testingggg");
  Serial.println("smack");

}

void loop()
{
  
  
  
 for (pot = 0; pot <= 90; pot += 1) {
  servo_9.write(pot);
   //Serial.print( "outer +" + pot);
  for (pos = 0; pos <= 90; pos += 1) {
       

    servo_8.write(pos);
  
    digitalWrite(trigPin, LOW);
    delayMicroseconds(2);
    digitalWrite(trigPin, HIGH);
    delayMicroseconds(10);
    digitalWrite(trigPin, LOW);
    duration = pulseIn(echoPin, HIGH);
    distance = duration * 0.034/2;
    Serial.println(distance);
    if (pos == 90) {
    Serial.println(1000.9);
    }
    
   
    delay(15); // Wait for 15 millisecond(s)
  }
 }

 for (pot = 90; pot >= 0; pot -= 1) {
  servo_9.write(pot);
  for (pos = 90; pos >= 0; pos -= 1) {


    servo_8.write(pos);
    digitalWrite(trigPin, LOW);
    delayMicroseconds(2);
    digitalWrite(trigPin, HIGH);
    delayMicroseconds(10);
    digitalWrite(trigPin, LOW);
    duration = pulseIn(echoPin, HIGH);
    distance = duration * 0.034/2;
    //Serial.println(distance);
    if (pos == 0) {
    Serial.println(1000.9);
    }
    delay(15); 
  }
 }
}
