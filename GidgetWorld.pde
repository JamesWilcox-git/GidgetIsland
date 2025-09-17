
//  MUST INSTALL SOUND LIBRARY FROM PROCESSING FOUNDATION  //

import processing.sound.*;
SoundFile file;
SoundFile cantAfford;
SoundFile dirtClick;
SoundFile launchSequence;
SoundFile rocketLaunch;
SoundFile shopClick;
SoundFile gidgetsInSpace;

// ArrayList to store multiple Gidget objects
ArrayList<Gidget> gidgets = new ArrayList<Gidget>(); 
// ArrayList to store properties
ArrayList<Property> properties = new ArrayList<Property>(); 
// new menu class object
Menu newMenu = new Menu(0, 0, 0, 0);

// sprites
PImage grassBackground;
PImage dirtMine;
PImage materialsBoard;

PImage gidgetIcon;
PImage dirtBlock;
PImage stoneBlock;
PImage oilBlock;
PImage oreBlock;
PImage ingotBlock;
PImage plus;

PImage waterBackground;
PImage sign;
PImage landForSale;
PImage gidgetHole;
PImage startScreen;
PImage propertyMenu;

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
PImage rocketPad;
PImage rocket;
PImage spaceWin;

// some global variables
float camX = 0; // Camera X position
float camY = 0; // Camera Y position

int totalWidth = 1000;
int totalHeight = 1000;

// menu visibility
boolean mainMenuVisible = true;
boolean propertyMenuVisible = false;
boolean spaceWinVisible = false;
boolean countDown = false;

Property clickedProperty = null;
int winCountDown = 11;
int lastSecond = -1;
float winTextY = 600;

void setup() {
  // Load theme music
  file = new SoundFile(this, "themeMusic.mp3");
  file.loop();
  
  // Load sounds 
  cantAfford = new SoundFile(this, "CantAfford.mp3");
  dirtClick = new SoundFile(this, "DirtClick.mp3");
  launchSequence = new SoundFile(this, "LaunchSequence.mp3");
  rocketLaunch = new SoundFile(this, "RocketLaunch.mp3");
  shopClick = new SoundFile(this, "ShopClick.mp3");
  gidgetsInSpace = new SoundFile(this, "GidgetsInSpace.mp3");
  
  // load game assets 
  grassBackground = loadImage("Textures/Grass1000.png");
  dirtMine = loadImage("Textures/DirtMine2.jpg");
  materialsBoard = loadImage("Textures/MaterialsBoard.jpg");
  
  dirtBlock = loadImage("Resources/DirtBlock.jpg");
  stoneBlock = loadImage("Resources/StoneBlock.jpg");
  oilBlock = loadImage("Resources/Oil.jpg");
  oreBlock = loadImage("Resources/Ore.jpg");
  ingotBlock = loadImage("Resources/Ingot.jpg");
  gidgetIcon = loadImage("Resources/GidgetIcon.png");
  plus = loadImage("Resources/Plus.png");
  
  waterBackground = loadImage("Textures/water2.jpg");
  sign = loadImage("Textures/Sign.jpg");
  landForSale = loadImage("Textures/LandForSale.jpg");
  gidgetHole = loadImage("Textures/GidgetHole.jpg");
  startScreen = loadImage("Textures/startScreen.jpg");
  propertyMenu = loadImage("Textures/propertyMenu.jpg");
  
  // load new sprites
  bigDirtMine = loadImage("Textures/BigDirtMine.jpg");
  bigDirtMineLVL2 = loadImage("Textures/BigDirtMineLVL2.jpg");
  stoneMine = loadImage("Textures/StoneMine.jpg");
  stoneMineLVL2 = loadImage("Textures/StoneMineLVL2.jpg");
  metalMine = loadImage("Textures/metalMine.jpg");
  smelter = loadImage("Textures/Smelter.jpg");
  oil = loadImage("Textures/Oil.jpg");
  warehouse = loadImage("Textures/Storage.jpg");
  bigWarehouse = loadImage("Textures/StorageLVL2.jpg");
  rocketPad = loadImage("Textures/RocketPad.jpg");
  rocket = loadImage("Textures/Rocket.png");
  spaceWin = loadImage("Textures/spaceWin.png");
  
  // V2 resize
  bigDirtMine.resize(bigDirtMine.width/2, bigDirtMine.height/2);
  bigDirtMineLVL2.resize(bigDirtMineLVL2.width/2, bigDirtMineLVL2.height/2);
  stoneMine.resize(stoneMine.width/2, stoneMine.height/2);
  stoneMineLVL2.resize(stoneMineLVL2.width/2, stoneMineLVL2.height/2);
  metalMine.resize(metalMine.width/2, metalMine.height/2);
  smelter.resize(smelter.width/2, smelter.height/2);
  oil.resize(oil.width/2, oil.height/2);
  warehouse.resize(warehouse.width/2, warehouse.height/2);
  bigWarehouse.resize(bigWarehouse.width/2, bigWarehouse.height/2);
  rocketPad.resize(rocketPad.width/2, rocketPad.height/2);
  //rocket.resize(rocket.width/2, rocket.height/2);
  
  // Resize some images
  propertyMenu.resize(500, 200);
  startScreen.resize(startScreen.width/2, startScreen.height/2);
  gidgetHole.resize(gidgetHole.width/2, gidgetHole.height/2);
  landForSale.resize(landForSale.width/2, landForSale.height/2);
  grassBackground.resize(grassBackground.width / 5, grassBackground.height / 5);
  spaceWin.resize(600,600);
  size(600, 600);
  rectMode(CENTER);
  textAlign(CENTER);
  
  // Initialize Properties
  for (int i = 0; i < 1000; i+=250) {
    for (int j = 0; j < 1000; j+=250) {
      if ((j == 250 && i == 250)  || (j == 250 && i == 500) || (j == 0 && i == 0)) {
      } else {
        Property property = new Property(i,j, landForSale);
        properties.add(property);
      }
    }
  }
}

void draw() {
  background(0,0,255);
  // change camera position based on input
  if (keyPressed) {
    if (key == 'a') camX -= 5; // Move left
    else if (key == 'd') camX += 5; // Move right
    else if (key == 'w') camY -= 5; // Move up
    else if (key == 's') camY += 5; // Move down
  }
  
  // dirt cannot surpass resource cap
  if (newMenu.dirt > newMenu.cap) {
    newMenu.dirt = newMenu.cap;
  }
  
  //Use seconds to update resources
  int currentSecond = second();
  if (currentSecond != lastSecond) {
    if (countDown == true) {
      winCountDown--;
      if(winCountDown == 1){rocketLaunch.play();}
      if(winCountDown == 0) {
        spaceWinVisible = true;
        gidgetsInSpace.play();
      }
    }
    for (Property p : properties) {
      p.resourceTicker();
    }
    lastSecond = currentSecond;
  }
  
  // Apply camera translation
  translate(-camX, -camY);

  //DRAW THE WORLD
  drawWater(); // Draw background
  noStroke();
  fill(255,179,102);
  square(500,500,1020); //island border
  drawGrass(); // draw island
  
  // important POI's
  image(rocketPad,10,10);
  image(rocket,-35,-420);
  image(dirtMine, 500, 250);
  image(sign, 480,230);
  image(gidgetHole, 225,225);
  computeGidgetPrice();
  
  // Draw border around currently selected property
  if(clickedProperty != null){
    fill(0,255,0);
    square(clickedProperty.x+75, clickedProperty.y+75, 160);
  }
  
  // Show Properties
  for (Property p : properties) {
    p.display();
  }
  
  // Show gidgets
  for (Gidget g : gidgets) {
    g.update();
    g.display();
  }
  
  // Reset camera translation!!!!!!!!!!
  translate(camX, camY); //STUFF AFTER MOVES WITH CAMERA, STUFF BEFORE DOES NOT

  // show mouse coords for testing
  fill(0);
  textSize(20);
  text("mouse x: " + (mouseX + camX) + "  mouse y: " + (mouseY + camY) , width/2,height - 5);

  // MENUS
  if (propertyMenuVisible == true) {
    image(propertyMenu, 50, 380);
  } else {
    clickedProperty = null;
  }
  if (mainMenuVisible == false) {
    // Material board on top of screen
    image(materialsBoard, 100, 0);
    newMenu.display();
  } else {
    // Tutorial menu
    image(startScreen,0,0);
  }
  if(winCountDown != 11){
    propertyMenuVisible = false;
    textSize(500);
    text(winCountDown, width/2, height/2 +200);
  }
  if (spaceWinVisible == true){
    textSize(20);
    image(spaceWin,0,0);
    fill(255);
    text("Bowen Wilcox\n Caya Wilcox\n\n\n Lost in a pixelated land\nWhere the colors intertwine\nGidgets in a square world\nDaring to leave behind\nBreaking out from Gidget Island\nSearching for a new place\nA pixel quest in outer space\nA cosmic embrace\n\n\nThey jump and hop through bitcrushed skies\nLighting up the night\nEight-bit wonders\nSmall creatures\nReady to take flight\nExploring constellations\nA retro game of their own\nGidgets in the universe\nWhere the stars have grown\n\n\nCosmic Gidgets on the run\nChasing dreams in the galactic sun\n8-bit heroes\nBrave and new\nTheir adventure shining through\nIn this pixelated quest\nThe Gidgets give it their best\nEscape the island\nReach for the stars\nThis is who they are\n", width/2, winTextY);
    winTextY-= 0.2;
  }
}

void goToShip(){
  for (Gidget g : gidgets) {
    g.goToShip = true;
  }
}

void mousePressed() {
  int x = mouseX;
  int y = mouseY;
  //print("\n" + x +"," +y);

  // Tutorial Menu X button
  if (x > 550 && y < 50 && mainMenuVisible == true){mainMenuVisible = false;}
  if (mainMenuVisible == false){
    
    if (propertyMenuVisible == true){
      if ((x > 525 && x < 549) && (y > 380 && y < 403)){
        propertyMenuVisible = false;
      }
      if (clickedProperty != null){
        shopClick.play();
        newMenu.checkPropertyMenuClicked(x, y, clickedProperty);
      }
    }
    
    if (!(propertyMenuVisible == true && (x > 48 && x < 551) && (y > 377 && y < 579))) {
      newMenu.checkClickHoleAndDirt(x,y,camX,camY,gidgets);
      for (Property p : properties) {
        Property clicked = p.clicked(x, y, camX, camY);
        if (clicked != null) {
          clickedProperty = clicked;
          break;
        }
      }
    }
    /*
    float xx = x+camX;
    float yy = y+camY;
    if (xx > 143 && xx < 279 && yy > 262 && yy < 305){
      cantAfford.play();
      launchSequence.play();
    }
    */
  }
}
