class Gidget {
  boolean goToShip = false;
  boolean invisible = false;
  int r;
  int g;
  int b;
  int size;
  int speed;
  int health;
  int change;
  int lifespan;
  int x;
  int y;
  int xdir;
  int ydir;
  float eyeDifx;
  float eyeDify;
  float eyeSize;
  float mouthSize;
  float mouthWidth;
  float mouthHeight;
  
  Gidget(int size, int speed, int health, int change, int x, int y){
    r = (int)random(1, 255);
    g = (int)random(1, 255);
    b = (int)random(1, 255);
    this.size = size;
    this.speed = speed;
    this.health = health;
    this.change = change;
    this.x = x;
    this.y = y;
    if (change < 1) { change = 1; }
    xdir = randomDir();
    ydir = randomDir();
    eyeDifx = random(-size/3, size/3);
    eyeDify = random(-size/3, size/3);
    eyeSize = random(size/10,size/3);
    //mouthSize = random(-size/2,size/2);
    mouthWidth = random(0,size);
    mouthHeight = random(0,size/4);
  }
  
  int randomDir(){
    return (int)random(-2, 2); // Updated to include -1, 0, 1 for xdir and ydir
  }
  
  // Shows Gidgets
  void display(){
    if (invisible == false){
      stroke(1);
      fill(r, g, b);
      square(x, y, size);
      fill(0);
      //eyes
      square(x-size/3 - eyeDifx, y-size/3 + eyeDify, eyeSize);
      square(x+size/3 + eyeDifx, y-size/3 + eyeDify, eyeSize);
      //mouth
      rect(x,y,mouthWidth,mouthHeight);
    }
  }
  
  // Gidget Movement
  void update() {
    for(int i = 0; i < change; i++){
      if ((int)random(100) == 10) {
        xdir = randomDir();
      } else if ((int)random(100) == 20){
        ydir = randomDir();
      } else if ((int)random(100) == 30){
        ydir = 0;
      } else if ((int)random(100) == 40){
        xdir = 0;
      }
    }
    if (goToShip == false) {
      x += speed * xdir; // Update x based on speed and direction
      y += speed * ydir; // Update y based on speed and direction
    } 
    if (goToShip == true) {
      if (x > 60) { x--; }
      if (y > 60) { y--; }
      if (x <= 60 && y <= 60) {
        invisible = true;
      }
    }
    
    // Adjust position to stay within canvas bounds
    x = constrain(x, size / 2, totalWidth - size / 2);
    y = constrain(y, size / 2, totalHeight - size / 2);
  } 
}
