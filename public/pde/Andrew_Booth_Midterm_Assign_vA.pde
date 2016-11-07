//
//Andrew Booth
//DMS 110
//Midterm Assignment
//Simple Animation - Planet System Clock
//

int squareSize = 700;

//Star drawing arrays
int starMax = int(4*squareSize/3);
int[] starX = new int[starMax];
int[] starY = new int[starMax];

void setup(){
  background(#FFFFFF);
  size(squareSize, squareSize);
  randomSeed(second());

  for(int starCount = 0; starCount < starY.length; starCount++){
    starX[starCount] = randInt(width);
    starY[starCount] = randInt(height);
  }

}//End of setup()



//Dimensionalization of necessary variables
//For star drawing
int size1;
int size2;
//frmRad used for pulsating bodies, as well as comet orbit
float frmRad;
//For sol revolving
int oSol;
float hSec;
float hRad;
//For world revolving
int oWorld;
float mSec;
float mRad;
//For moon rotating
int oMoon;
float sFrm;
float sRad;
int pSecond = second();
int currFrm;
float tauPart;
//For moon shadow
float mnXDif;
float mnYDif;
float mnPyth;
float mnRad;
//For comet rotating
int oComet;
//For comet shadow
float ctXDif;
float ctYDif;
float ctPyth;
float ctRad;

//Body objects for clock
Body center = new Body(1);
Body sol = new Body(2);
Body world = new Body(3);
Body moon = new Body(4);
Body comet = new Body(5);

Body mnCent = new Body(0);
Body moon1 = new Body(4);
Body moon2 = new Body(4);

void draw(){
  background(0);  //Draw background
  noStroke();
  fill(#000000);
  for(int starCount = 0; starCount < starMax; starCount++){
    //Draws stars
    noStroke();
    fill(#FFFFFF);
    size1 = randInt(3, 7);
    size2 = 1;
    ellipse(starX[starCount],starY[starCount], size1, size2);
    ellipse(starX[starCount],starY[starCount], size2, size1);
  }//End star draw

  frmRad = TWO_PI*(frameCount%60)/frameRate;  //frmRad used for pulsating bodies, as well as comet orbit

  //Draw black hole
  center.drawBody(int(width/2), int(height/2), int(height/12 + height*cos(frmRad)/378));

  //Draw sol revolving
  oSol = int(height/4);
  hSec = hour()*3600 + minute()*60 + second();
  hRad = TWO_PI*hSec/43200;  //12 hour clock
  //hRad = TWO_PI*hSec/86400;  //24 hour clock
  sol.drawBody(int(center.getX() + oSol*sin(hRad)), int(center.getY() - oSol*cos(hRad)), int(height/12));

  //Draw world revolving
  oWorld = int(height/8);
  mSec = minute()*60 + second();
  mRad = TWO_PI*mSec/3600;
  world.drawBody(int(sol.getX() + oWorld*sin(mRad)), int(sol.getY() - oWorld*cos(mRad)), int(height/38));
  //Draw world shadow
  fill(#000000, 128);
  arc(world.getX(), world.getY(), world.getDiameter() + 1, world.getDiameter() + 1, PI + mRad, TWO_PI + mRad);


  //Draw moon rotating
  if (pSecond != second()){
    currFrm = frameCount;
  }
  tauPart = (((frameCount - currFrm)/frameRate)*TAU/60);
  oMoon = int(height/20);
  sFrm = second();
  sRad = TWO_PI*sFrm/60;
  moon.drawBody(int(world.getX() + oMoon*sin(sRad + tauPart)), int(world.getY() - oMoon*cos(sRad + tauPart)), int(height/94));
  //Draw moon shadow
  mnXDif = moon.getX() - sol.getX();
  mnYDif = moon.getY() - sol.getY();
  mnPyth = sqrt(sq(mnXDif) + sq(mnYDif));
  mnRad = asin(mnYDif/mnPyth);
  fill(#000000, 160);
  if (mnXDif >= 0){
    arc(moon.getX(), moon.getY(), moon.getDiameter() + 1, moon.getDiameter() + 1, mnRad - HALF_PI, HALF_PI + mnRad);
  }else{
    arc(moon.getX(), moon.getY(), moon.getDiameter() + 1, moon.getDiameter() + 1, HALF_PI - mnRad, PI + HALF_PI - mnRad);
  }

  //Draw comet rotating
  oComet = int(height/55);
  comet.drawBody(int(moon.getX() + oComet*sin(frmRad)), int(moon.getY() - oComet*cos(frmRad)), int(height/150));
  //Draw comet shadow
  ctXDif = comet.getX() - sol.getX();
  ctYDif = comet.getY() - sol.getY();
  ctPyth = sqrt(sq(ctXDif) + sq(ctYDif));
  ctRad = asin(ctYDif/ctPyth);
  fill(#000000, 160);
  if (mnXDif >= 0){
    arc(comet.getX(), comet.getY(), comet.getDiameter() + 1, comet.getDiameter() + 1, ctRad - HALF_PI, HALF_PI + ctRad);
  }else{
    arc(comet.getX(), comet.getY(), comet.getDiameter() + 1, comet.getDiameter() + 1, HALF_PI - ctRad, PI + HALF_PI - ctRad);
  }
/*
  //Make moon center
  int oMNCent = int(width/24);
  mnCent.drawBody(int(world.getX() + oMoon*sin(sRad)), int(world.getY() - oMoon*cos(sRad)), int(height/94));

  int oMoonBoth = int(width/128);
  moon1.drawBody(int(mnCent.getX() + oMoonBoth*sin(frmRad)), int(mnCent.getY() - oMoonBoth*cos(frmRad)), 5);
  moon2.drawBody(int(mnCent.getX() - oMoonBoth*sin(frmRad)), int(mnCent.getY() + oMoonBoth*cos(frmRad)), 5);
*/

  //Mouse tracking conditionals
  if ((center.getX() - center.getDiameter()/2 <= mouseX) && (mouseX <= center.getX() + center.getDiameter()/2) && (center.getY() - center.getDiameter()/2 <= mouseY) && (mouseY <= center.getY() + center.getDiameter()/2)){
    center.drawInterface(oSol);
  }

  if ((sol.getX() - sol.getDiameter()/2 <= mouseX) && (mouseX <= sol.getX() + sol.getDiameter()/2) && (sol.getY() - sol.getDiameter()/2 <= mouseY) && (mouseY <= sol.getY() + sol.getDiameter()/2)){
    sol.drawInterface(oWorld);
  }

  if ((world.getX() - world.getDiameter()/2 <= mouseX) && (mouseX <= world.getX() + world.getDiameter()/2) && (world.getY() - world.getDiameter()/2 <= mouseY) && (mouseY <= world.getY() + world.getDiameter()/2)){
    world.drawInterface(oMoon);
  }

  pSecond = second();
}//End draw()



//Functions
int randInt(int h){
//Returns a random integer
  return int(random(h));
}
int randInt(int l, int h){
//Override for hight and low
  return int(random(l, h));
}
