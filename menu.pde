class Menu{
  int dirt;
  int stone;
  int ore;
  int ingots;
  int oil;
  int gidgetBucks;
  int gidgetCores;
  int gidgets;
  int cap;
  Menu(int dirt, int stone, int gidgetBucks, int gidgetCores){
    this.dirt = dirt;
    this.stone = stone;
    this.gidgetBucks = gidgetBucks;
    this.gidgetCores = gidgetCores;
    ore = 0;
    oil = 0;
    ingots = 0;
    gidgets = 0;
    cap = 100;
  }
  
  int getMaterial(String material){
    if(material == "dirt"){
      return dirt;
    } else if (material == "stone") {
      return stone;
    } else if (material == "oil") {
      return oil;
    } else if (material == "ore") {
      return ore;
    } else if (material == "ingots") {
      return ingots;
    } else if (material == "gidgets") {
      return gidgets;
    } else {
      return -1;    
    }
  };
  
  void changeMaterial(int mult, String material, int amount){
    if(material == "dirt"){
      dirt+= (mult * amount);
    } else if (material == "stone") {
      stone+= (mult * amount);
    } else if (material == "oil") {
      oil+= (mult * amount);
    } else if (material == "ore") {
      ore+= (mult * amount);
    } else if (material == "ingots") {
      ingots+= (mult * amount);
    }
  };
  
  void display(){
    fill(0);
    // dirt
    square(width/2-170, 30, 0);
    image(dirtBlock, width/2 -180, 5);
    textSize(20);
    text(dirt, width/2 -120, 21);
    
    // stone 
    image(stoneBlock, width/2 -80, 5);
    text(stone, width/2 -20, 21);
    
    // ore
    image(oilBlock, width/2 +20, 5);
    text(oil, width/2 +80, 21);
    
    image(oreBlock, width/2 +120, 5);
    text(ore, width/2 +165, 21);
    
    image(ingotBlock, width/2 +120, 35);
    text(ingots, width/2 +165, 51);
    
    image(gidgetIcon, width/2 +20, 35);
    text(gidgets, width/2 + 80, 51);
    
    textSize(23);
    text("Resource Cap: " + cap, width/2 - 100, 49);
    
  }
  
  // Checks if the player is clicking the gidget hole or dirt mine
  void checkClickHoleAndDirt(int X, int Y, float camX, float camY, ArrayList<Gidget> gidgetList ){
    int x = (int)(X+camX);
    int y = (int)(Y+camY);
    // rocket
    if (x > 10 && x < 160 && y > 100 && y < 160){
      if(newMenu.oil >= 100 && newMenu.ingots >= 100) {
        newMenu.oil-=100;
        newMenu.ingots-=100;
        file.pause();
        launchSequence.play();
        countDown = true;
        goToShip();
      } else {
        cantAfford.play();
      }
    };
    // Dirt
    if((x > 500 && x < 600) && (y > 250 && y < 350)){
      dirtClick.play();
      dirt+=(1+((int)gidgets/2)); // CHANGE LATER
    }
    // Hole
    if((x > 225 && x < 325) && (y > 225 && y < 325)){
      if(dirt >= (gidgets*10 + 10)) {
        dirt -= (gidgets*10 + 10);
        Gidget newGidget = new Gidget((int)random(30,35), (int)random(1,5), (int)random(10,100), (int)random(1,5), width/2, height/2);
        gidgetList.add(newGidget);
        gidgets++;
      }
    }
  };
  
  // I wrote it, it works, I literally do not need it at all 
  void outlineText(String text, int theTextSize, int borderThickness, float x, float y){
    fill(178, 134, 91);
    textSize(theTextSize);
    for(int k = -1; k < 2; k++){
      for(int j = -1; j < 2; j++){
        text(text, k+x, j+y);
      }
    }
  }
  
  void checkPropertyMenuClicked(int x, int y, Property p){
    //dirt
    if ((x > 178 && x < 232) && (y > 406 && y < 433)){
      p.changeToDirt();
    }
    //stone
    if ((x > 178 && x < 231) && (y > 454 && y < 479)){
      p.changeToStone();
    }
    //iron
    if ((x > 178 && x < 231) && (y > 516 && y < 542)){
      p.changeToMetal();
    }
    //dirtmine2
    if ((x > 324 && x < 378) && (y > 404 && y < 429)){
      p.changeToDirt2();
    }
    //stonemine2
    if ((x > 324 && x < 378) && (y > 451 && y < 476)){
      p.changeToStone2();
    }
    //smelter
    if ((x > 324 && x < 378) && (y > 512 && y < 537)){
      p.changeToSmelter();
    }
    //warehouse
    if ((x > 475 && x < 529) && (y > 411 && y < 437)){
      p.changeToWarehouse();
    }
    //warehouse2
    if ((x > 481 && x < 534) && (y > 446 && y < 472)){
      p.changeToBigWarehouse();
    }
    //oil
    if ((x > 438 && x < 493) && (y > 510 && y < 536)){
      p.changeToOil();
    }
    //destroy
    if ((x > 467 && x < 522) && (y > 544 && y < 570)){
      p.changeToDefault();
    }
  }
}

/*
button coords start then finish
COLL 1
dirt
if ((x > 178 && x < 232) && (y > 406 && y < 433)){}
178,406
232,433

stone
if ((x > 178 && x < 231) && (y > 454 && y < 479)){}
177,454
231,479

iron
if ((x > 178 && x < 231) && (y > 516 && y < 542)){}
177,516
231,542


COLL 2
dirtmine2
if ((x > 324 && x < 378) && (y > 404 && y < 429)){}
324,404
378,429

stonemine2
if ((x > 324 && x < 378) && (y > 451 && y < 476)){}
324,451
378,476

smelter
if ((x > 324 && x < 378) && (y > 512 && y < 537)){}
323,512
377,537


COLL 3
warehouse
if ((x > 475 && x < 529) && (y > 411 && y < 437)){}
475,411
529,437

warehouse2
if ((x > 481 && x < 534) && (y > 446 && y < 472)){}
481,446
534,472

oil
if ((x > 438 && x < 493) && (y > 510 && y < 536)){}
438,510
493,536

destroy
if ((x > 467 && x < 522) && (y > 544 && y < 570)){}
467,544
522,570
*/
