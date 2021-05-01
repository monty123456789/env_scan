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
Float first;
int newLine = 0;
int index = 0;
int index2 = 0;

int rotation = 180;

Float z = 0.0;

float xcor;
float xcor2;
int x2;
int x;
Float count = .0;
float count2;

int h = height/45;
int w = width/45;


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

  //directionalLight(vas, vas, vas, 0, -10, 0);
 lights();

  //reads the data from arduino, stores as a string to 'val'
  val = myPort.readStringUntil('\n');
  if ( val != null) 
  { 
    //converts string of arduino data to a float
    Float va = Float.valueOf(val).floatValue();

    // coList is created to store the second plot point for the graph line to be drawn to. 
    if (va != 1000.9) {
      coList.append(vat);
      fullList.append(vat);
    }

    // by assigning the second to last coordinates to the new variable, this can be given as a plot point

    // in arduino, when each rotation is complete '1000.9' is serial printed, and so if processing receives
    // that number, it clears the data from coList, which is the list that the second coordinates are stored 
    ////in so as to cnnect the graph. 
    //resets the x coordinate to 0 every time the servo finishes a loop. 
    // x is removed from the y coordinate with every loop, so each new line is plotted on a new level. 

    if (va == 1000.9 || coList.size() > rotation-9 ) { //|| coList.size() > 90
      coList.clear();
      newLine +=1;
      count = 0.0;
      x += height/rotation;
      //x += va;
    }

    // count is assigned to the x coordinate so with each new plot points, the coordinate moves across
    // the screen. 
    count += width/rotation;
    println(x);
    count2 = count - width/rotation;
    x2 = x-(height/rotation);


    //maps distance coordiantes to rgb values
    vas = map(va, 25, 40, 255, 50);

    //makes shape is more pronounced.
    vat = va; //map(va, 25, 44, va, va*3);

    lines();
    //fill(vas);
    //circle(count, xcor, 7);

    saveFrame("3d_c43.jpg");
  }
}








void spheres() {
  camera(5, 500, (height/2) / tan(PI/6), width/2, height/2, 0, 0, 1, 0);
  fill(vas);
  noStroke();
  translate(count, x, -(vat));
  sphere(2);
}



void lines() {
  camera(5, 500, (height/2) / tan(PI/6), width/2, height/2, 0, 0, 1, 0);
  if (coList.size() < 4 ) {
    
    stroke(0);
    xcor = -(vat);
    xcor2 = -(vat);
  } else if (coList.size() > 3 ) {
   index = coList.size();

    stroke(vas);
    strokeWeight(1);
    last = coList.get((index - 2)); 
    first = coList.get((index-1));
    print(count + "  " + count2 + "b  ");

    xcor = -(first);
    xcor2 = -(last);
  } 
  line(count, x, xcor, count2, x, xcor2);
}



void spheresList() {
  camera(5, 500, (height/2) / tan(PI/6), width/2, height/2, 0, 0, 1, 0);

  if (va != 0) {
    //maps distance coordiantes to rgb values
    // vas = map(va, 2, 50, 255, 50);

    // count is assigned to the x coordinate so with each new plot points, the coordinate moves across
    // the screen. 

    vat = va;
    // print(vat + "b    ");
    fullList.append(vat);
    if (fullList.size() > 1) {
      index2 = fullList.size();
      if (z == 1000.9) {
        newLine +=1;
        count = 0.0;
        x += height/90;
      }

      if (newLine == 1) {
        int i = 1;
        while (i < fullList.size()) {
          i = i+1;
          z = fullList.get(i-1);
          // print(z + "z    ");
          // print(i + "b      ");
          count += width/90;
          fill(vas);
          noStroke();
          translate(count, x, -z);
          sphere(2);
        }
      }
    }
  }
}
