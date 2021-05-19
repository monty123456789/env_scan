import processing.serial.*;

ArrayList<Co> cos = new ArrayList<Co>();

Serial myPort;  // Create object from Serial class
PGraphics pg;

String val;
float va;
Float vat = 0.0;
Float vas = 0.0;

float xp, y, zp;

int test;

FloatList coList;
FloatList fullList;
Float last = 0.0; 
Float first;
int newLine = 0;
int index = 0;
int index2 = 0;

int rotation = 180;
int rY = 135;

Float z = 0.0;

float xcor;
float xcor2;
int x2;
int x;
Float count = .0;
float count2;

int h = height/45;
int w = width/45;
String portName;

void setup()
{
  size(720, 480, P3D);
  background(0);

  portName = Serial.list()[2]; 
  myPort = new Serial(this, portName, 9600);
  coList = new FloatList();
  fullList = new FloatList();
}


void draw() {
  background(0);
  camera(mouseX, mouseY, (height/2) / tan(PI/6), width/2, height/2, 0, 0, 1, 0);

  //directionalLight(vas, vas, vas, 0, -10, 0);
  lights();

  //reads the data from arduino, stores as a string to 'val'
  val = myPort.readStringUntil('\n');
  if ( val != null) 
  { 
    //converts string of arduino data to a float
    Float va = Float.valueOf(val).floatValue();
    // printArray(va);
    //maps distance coordiantes to rgb values
    vas = map(va, 60, 230, 255, 20);

    //makes shape is more pronounced.
    vat = va; //map(va, 25, 44, va, va*3);


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
    //println(coList.size());
    if (va == 1000.9 || coList.size() > rotation-2 ) {
      println(coList.size());
      //|| coList.size() > 90
      coList.clear();
      fullList.clear();
      //newLine +=1;
      count = 0.0;
      x += height/rotation;
      //x += va;
    }

    // count is assigned to the x coordinate so with each new plot points, the coordinate moves across
    // the screen. 
    count += width/rotation;

    count2 = count - width/rotation;

    
  
}
  
    
    
    



    //wave();
    wave();
    //spheres();
    //fill(vas);
    //circle(count, xcor, 7);

    //saveFrame("3d_####.jpg");
  
}




















void spheres() {


  pushMatrix();
  // camera(5, 500, (height/2) / tan(PI/6), width/2, height/2, 0, 0, 1, 0);

  noStroke();
  if (va != 1000.9) {
    translate(count, x, -(vat));
    sphere(5);
    popMatrix();
  }
}

void wave() {
  cos.add(new Co(count, x, -vat));
      
      for (int i = cos.size()-1; i>0; i--) {
      //Co n = cos.get(i);
           
      Co m = cos.get(i-1);
      //n.threed();
      m.threed();
      xp = m.position.x;
      y = m.position.y;
      zp = m.position.z;
      
      float c = zp;
      fill(255);
      //println(x, 12);
      if (x > (height/rotation)*10) {
        m.nois();
        portName = Serial.list()[3]; 
       // n.nois();
      }
      //pushMatrix();
      //beginShape();
      //translate(m.position.x, m.position.y);
      //// vertex(m.position.x, m.position.y);
      ////  vertex(n.position.x, n.position.y);

      //vertex(0, 0);

      //endShape();
      //popMatrix();
    }
}



//if (coList.size() > 3) {
// index2 = fullList.size();
// float co = coList.get(index);
// float full = fullList.get(index2);
// float add = (co + full) /2;
// pushMatrix();
// translate(count - (width/rotation/2), x - (height/rotation/2), -add);
// sphere(2);
// popMatrix();
// println(vat);
// println(add);
// }
//void middle() {
//  index = coList.size();
//  index2 = fullList.size();
//  float co = coList.get(index);
//  float full = fullList.get(index2);
//  float add = (co + full) /2;
//}


void lines() {
  scale(1.5, 1);
  //camera(5, 500, (height/2) / tan(PI/6), width/2, height/2, 0, 0, 1, 0);
  if (coList.size() < 4 ) {

    stroke(0);
    xcor = -(vat);
    xcor2 = -(vat);
  } else if (coList.size() > 3 ) {
    index = coList.size();

    //stroke(vas);
    strokeWeight(2);
    last = coList.get((index - 2)); 
    first = coList.get((index-1));

    xcor = -(first);
    xcor2 = -(last);
  } 
  //translate(count-100, x, xcor);
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
