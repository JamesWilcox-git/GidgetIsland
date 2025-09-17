void drawGrass(){
  for (int i = 0; i < 1000; i += 200) {
    for (int b = 0; b < 1000; b += 200) {
      image(grassBackground, i, b);
    }
  }
}

void drawWater(){
   for (int i = -2000; i < 2000; i += 400) {
    for (int b = -2000; b < 2000; b += 400) {
      image(waterBackground, i, b);
    }
  }
}

void computeGidgetPrice(){
  fill(143, 99, 60);
  textSize(35);
  image(dirtBlock,270, 365);
  int gidgetAmount = newMenu.getMaterial("gidgets");
  text((gidgetAmount*10 + 10), 315, 385);
}
