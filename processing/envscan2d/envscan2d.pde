import processing.serial.*;

Serial myPort;  // Create object from Serial class
String val;
FloatList coList;
float va;
PGraphics pg;


void setup()
{
  size(720, 480);
  background(0);
  // I know that the first port in the serial list on my mac
  // is Serial.list()[0].
  // On Windows machines, this generally opens COM1.
  // Open whatever port is the one you're using.
  String portName = Serial.list()[1]; //change the 0 to a 1 or 2 etc. to match your port
  myPort = new Serial(this, portName, 9600);
  //println(Serial.list());
    coList = new FloatList();
    coList.append(1);


}
Float count = 0.0;
int x = 1;
void draw()
{
  
   translate(0, height);
  // circle(0,-100,10);
  //reads the data from arduino, stores as a string to 'val'
  val = myPort.readStringUntil('\n');
  if ( val != null) 
  { 
  //converts string of arduino data to a float
  Float va = Float.valueOf(val).floatValue();
  //print(va + "  ");
  

  
// in arduino, when each rotation is complete '1000.9' is serial printed, and so if processing receives
// that number, it clears the data from coList, which is the list that the second coordinates are stored 
////in so as to cnnect the graph. 
  if (va == 1000.9) {
    coList.clear();
  }
  
  
  if (va != 0) {

  //stroke(255);
  //println(" " + val);
  //print(val); //print it out in the console
 // print(va);  //for (int i = 0; i <width; i++) {
   
  // count is assigned to the x coordinate so with each new plot points, the coordinate moves across
  // the screen. 
  count += width/90;
  
  // doubles the size of the cooordinates to make the shape more pronounced. 
  Float vat = va*2;
  
  Float vas = map(va, 15, 80, 255, 0);
  print(vas + "a    ");
  
  //resets the x coordinate to 0 every time the servo finishes a loop. 
  if (va==1000.90) {
      count = 0.0;
     // x is removed from the y coordinate with every loop, so each new line is plotted on a new level. 
      x += height/90;
      
  }
  
  // coList is created to store the second plot point for the graph line to be drawn to. 
  coList.append(vat);
  
// by assigning the second to last coordinates to the new variable, this can be given as a plot point
  int index = coList.size();
  
  if (coList.size() > 1 ) {
    Float last = coList.get((index - 2));      
    float xcor = -(vat+x);
    float xcor2 = -(last +x);
    float count2 = count - width/90;
    
    //draws the line 
      //stroke(va,0,255-va);
      //circle(count,xcor,2);
      //stroke(255);

      
      line(count2, xcor2, count, xcor);
      stroke(vas,0,255-vas);

      //if (vat > 0) {
        //pg.beginDraw();
       // clear();
        //line(320, 480, count, xcor);
       // pg.endDraw();
       saveFrame("2d_38.jpg");
  
  }
  
  
  }
  }
  }
