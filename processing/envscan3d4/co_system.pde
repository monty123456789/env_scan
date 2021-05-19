class Co {
  PVector wind, position, co, w, w2, w3, w4, mult; 
     float wi, wi2, wi3, wi4;
  float noiseV;
  float noiz, noiz2, noiz3, noiz4, noiz2z, noiz3z, x;
  
  Co(float x, float y, float z) {
    
   
   position = new PVector(x, y, z);
  
  }
  
  void update() {
    run();
    nois();
  }
  
  void threed() {
     pushMatrix();
     //fill(255);
     translate(position.x, position.y, position.z);
     sphere(2);
     noStroke();
      //fill(255);
     popMatrix();
  }
  
  void run() {
  
    noStroke();
    //fill(255);
  circle(position.x, position.y, 2);
    
  }
  
 
      
  
  void wid() {
    wi = position.dist(w);
    wi2 = position.dist(w2);
    wi3 = position.dist(w3);
    wi3 = position.dist(w3);
    
    wi3/=250;
    wi4/=500;
    wi2/=250;
    wi/=500;
    position.sub(0, 0);
  }
  
  void nois() {
    x += .0001;
    noiz = noise((position.y * .001) -100);
    noiz2 = noise((position.x * .001) + 100);
    noiz3 = noise(position.y * .005);
    noiz4 = noise(position.x * .005);
    
    position.add(noiz, noiz2);
    position.sub(noiz3, noiz4);
  }
  
  void edge() {
    
    if (position.y > height) {
      position.sub(0, height);
    } else if (position.x > width) {
       position.sub(width, 0);     
    } 
    
    
  }
  
  
  void leftright() {
    for (int i = 0; i< 1200; i++) {
      if (i< 600) {
        position.add(wi2, wi2);
      } else if (i> 600) {
        position.sub(wi2, wi2);
      }
    }
  }
  

    
}
