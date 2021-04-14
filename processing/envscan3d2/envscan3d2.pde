import processing.serial.*;

Serial myPort;  // Create object from Serial class
PGraphics pg;

String val;
float va;
Float vat = 0.0;
Float vas = 0.0;

FloatList coList;
FloatList fullList;
Float last = 0.0;  
int newLine = 0;
int index = 0;
int index2 = 0;

Float z = 0.0;

float xcor = 1110.0;
float xcor2 = 1110.0;
int x2 = 1;
int x = 1;
Float count = -10.0;
float count2 = 0.0;


void setup()
{
  size(720, 480, P3D);
  background(0);

  String portName = Serial.list()[1]; 
  myPort = new Serial(this, portName, 9600);
  coList = new FloatList();
  fullList = new FloatList();
  

}


void draw() {

  lights();
  directionalLight(51, 102, 126, 0, -1, 0);

  //reads the data from arduino, stores as a string to 'val'
  val = myPort.readStringUntil('\n');
  if ( val != null) 
  { 
    //converts string of arduino data to a float
    Float va = Float.valueOf(val).floatValue();

    // coList is created to store the second plot point for the graph line to be drawn to. 
   

    // by assigning the second to last coordinates to the new variable, this can be given as a plot point
    index = coList.size();
    index2 = coList.size();
    x2 = x-(height/90);
    count2 = count - width/90;

    // in arduino, when each rotation is complete '1000.9' is serial printed, and so if processing receives
    // that number, it clears the data from coList, which is the list that the second coordinates are stored 
    ////in so as to cnnect the graph. 
    //resets the x coordinate to 0 every time the servo finishes a loop. 
    // x is removed from the y coordinate with every loop, so each new line is plotted on a new level. 

    if (va == 1000.9) {
      coList.clear();
      newLine +=1;
      count = 0.0;
      x += height/90;
    }

    if (va != 0) {
      //maps distance coordiantes to rgb values
      vas = map(va, 2, 50, 255, 50);

      // count is assigned to the x coordinate so with each new plot points, the coordinate moves across
      // the screen. 
      count += width/45;
      vat = va;
      print(vat + "a    ");
      coList.append(vat);
      fullList.append(vat);
      
      lines();


      saveFrame("3d_b15.jpg");
    }
  }
}

void spheres() {
  camera(5, 500, (height/2) / tan(PI/6), width/2, height/2, 0, 0, 1, 0);
  //if (newLine == 1) {
    //int i = 1;
    //while (i < fullList.size()) {
    //  i = i+1;
    //  print(i + "a      ");
    //   z = fullList.get(index-1);
      fill(vas,0,255-vas);
      noStroke();
      translate(count, x, -vat);
      sphere(2);
    
  }


void lines() {
  camera(5, 500, (height/2) / tan(PI/6), width/2, height/2, 0, 0, 1, 0);

 if (coList.size() < 4 ) {
        xcor = -(0);
        xcor2 = -(0);
 } else if (coList.size() > 3 ) {
    last = coList.get((index - 2));      
    xcor = -(vat);
    xcor2 = -(last);
    line(count, x, xcor, count2, x2, xcor2);
    stroke(vas);
 } 
    
  
  
}
