class Property{
  int x;
  int y;
  int xLower;
  int xUpper;
  int yLower;
  int yUpper;
  PImage propertyType;
  
  Property(int x, int y, PImage type){
    this.x = x;
    this.y = y;
    this.propertyType = type;
  }
  
  void display(){
    image(propertyType, x,y);
    //doAnimation("s");
  }
  
  Property clicked(int X, int Y, float camX, float camY){
    int clickX = (int)(X+camX);
    int clickY = (int)(Y+camY);
    if((clickX > x && clickX < x+150) && (clickY > y && clickY < y+150)){
      propertyMenuVisible = true;
      return this;
    }
    return null;
  }
  
  // Buildings create resources
  void resourceTicker(){
    if(this.propertyType == bigDirtMine){
      newMenu.dirt++;
    } else if (this.propertyType == bigDirtMineLVL2){
      newMenu.dirt += 10;
    } else if (this.propertyType == stoneMine){
      newMenu.stone++;
    } else if (this.propertyType == stoneMineLVL2){
      newMenu.stone += 10;
    } else if (this.propertyType == metalMine){
      newMenu.ore++;
      newMenu.ore++;
    } else if (this.propertyType == smelter){
      //MAKE SO NEEDS OIL
      if (newMenu.ore > 4){
        newMenu.ore -= 4;
        newMenu.ingots++;
        newMenu.ingots++;
      }
    } else if (this.propertyType == oil){
      newMenu.oil++;
      newMenu.oil++;
    }
    // if resources have exceeded resource cap, set them equal to resource cap
    if(newMenu.dirt > newMenu.cap) {newMenu.dirt = newMenu.cap;}
    if(newMenu.stone > newMenu.cap) {newMenu.stone = newMenu.cap;}
    if(newMenu.ore > newMenu.cap) {newMenu.ore = newMenu.cap;}
    if(newMenu.ingots > newMenu.cap) {newMenu.ingots = newMenu.cap;}
    if(newMenu.oil > newMenu.cap) {newMenu.oil = newMenu.cap;}
  }
  
  /*
  void doAnimation(String resourceType){
    for(int i = 0; i < 200; i ++){
      image(plus, x, y-i);
    }
  };
  */

  // VARIOUS PROPERTY CHANGE FUNCTIONS

  void changeToDefault(){
    if(this.propertyType == warehouse) { newMenu.cap -= 100; }
    if(this.propertyType == bigWarehouse) { newMenu.cap -= 1000; }
    this.propertyType = landForSale;  
  }
  
  void changeToDirt(){
    if(newMenu.dirt >= 50 && this.propertyType == landForSale){
      newMenu.dirt -= 50;
      this.propertyType = bigDirtMine;
    } else {
      cantAfford.play();
    }
  }
  
  void changeToDirt2(){
    if(newMenu.stone >= 30 && this.propertyType == landForSale && newMenu.gidgets >= 10){
      newMenu.stone -= 30;
      //DELETE 10 GIDGETS
      this.propertyType = bigDirtMineLVL2;
    } else {
      cantAfford.play();
    }
  }
  
  void changeToStone(){
    if(newMenu.dirt >= 100 && this.propertyType == landForSale && newMenu.gidgets >= 4){
      newMenu.dirt -= 100;
      // DELETE 4 GIDGETS
      this.propertyType = stoneMine;
    } else {
      cantAfford.play();
    }
  }
  
  void changeToStone2(){
    if(newMenu.dirt >= 500 && this.propertyType == landForSale && newMenu.gidgets >= 10){
      newMenu.dirt -= 500;
      // DELETE 10 GIDGETS
      this.propertyType = stoneMineLVL2;
    } else {
      cantAfford.play();
    }
  }
  
  void changeToMetal(){
    if(newMenu.stone >= 100 && this.propertyType == landForSale && newMenu.gidgets >= 1){
      newMenu.stone -= 100;
      // DELETE 1 GIDGETS
      this.propertyType = metalMine;
    } else {
      cantAfford.play();
    }
  }
  
  void changeToSmelter(){
     if(newMenu.ore >= 150 && this.propertyType == landForSale){
      newMenu.ore -= 150;
      this.propertyType = smelter;
    } else {
      cantAfford.play();
    }
  }
  
  void changeToOil(){
     if(newMenu.ingots >= 100 && this.propertyType == landForSale){
      newMenu.ingots -= 100;
      this.propertyType = oil;
    } else {
      cantAfford.play();
    }
  }
  
  void changeToWarehouse(){
     if(newMenu.stone >= 100 && this.propertyType == landForSale){
      newMenu.stone -= 100;
      this.propertyType = warehouse;
      newMenu.cap += 100;
    } else {
      cantAfford.play();
    }
  }
  
  void changeToBigWarehouse(){
     if(newMenu.ingots >= 20 && this.propertyType == landForSale){
      newMenu.ingots -= 20;
      this.propertyType = bigWarehouse;
      newMenu.cap += 1000;
    } else {
      cantAfford.play();
    }
  } 
}
/*
// new sprites (V2)
PImage bigDirtMine;
PImage bigDirtMineLVL2;
PImage stoneMine;
PImage stoneMineLVL2;
PImage metalMine;
PImage smelter;
PImage oil;
PImage warehouse;
PImage bigWarehouse;

button coords start then finish
178,406
232,433
177,454
231,479
177,516
231,542
324,404
378,429
324,451
378,476
323,512
377,537
475,411
529,437
481,446
534,472
438,510
493,536
467,544
522,570
*/
