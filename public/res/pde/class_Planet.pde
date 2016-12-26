class Body{
  int _type;
  int _xPosition;
  int _yPosition;
  int _diameter;

  Body(int t){
    //Only class constructor
    _type = t;
  }


  int getType(){
    //Type getter
    return _type;
  }

  void setX(int x){
    //X coordinate setter
    _xPosition = x;
  }
  int getX(){
    //X coordinate getter
    return _xPosition;
  }

  void setY(int y){
    //Y coordinate setter
    _yPosition = y;
  }
  int getY(){
    //Y coordinate getter
    return _yPosition;
  }

  void setDiameter(int d){
    //Diameter setter
    _diameter = d;
  }
  int getDiameter(){
    //Diameter getter
    return _diameter;
  }

  void drawBody(int x, int y, int d){
  //Draws planet depending on type

    setX(x);
    setY(y);
    setDiameter(d);
    noStroke();
    switch(_type){
      case 0:
        //"Invisible planet"
        break;
      case 1:
        //Black hole (center, pulsates for no particular reason)
        fill(#000000);
        // stroke(randInt(255), randInt(255), randInt(255), 80);
        stroke(255, 255, 255, 80);
        strokeWeight(1);
        ellipse(getX(), getY(), getDiameter(), getDiameter());
        break;
      case 2:
        //Sol (hours, revolves twice a day)
        fill(#FFF700);
        ellipse(getX(), getY(), getDiameter(), getDiameter());
        //Sol aura
        fill(#FFF700, 64);
        ellipse(getX(), getY(), 11*getDiameter()/10, 11*getDiameter()/10);
        break;
      case 3:
        //World (minutes, revolves once an hour)
        fill(#D16AFA);
        ellipse(getX(), getY(), getDiameter(), getDiameter());
        break;
      case 4:
        //Moon  (seconds, revolves once a minute)
        fill(#24EAE5);
        ellipse(getX(), getY(), getDiameter(), getDiameter());
        break;
      case 5:
        //Comet (revolves once a second)
        fill(#FF0000);
        ellipse(getX(), getY(), getDiameter(), getDiameter());
        break;
      default:
        println("ERR: drawBody() switch(type) defaulted");
        break;
    }//End switch(_type)
  }//End drawBody()

  void drawInterface(int o){
  //Draws clock interface given orbit
    int lineMax = 0;
    int lineMod = 0;

    noFill();
    stroke(#FFFFFF, 128);
//    rect(getX() - getDiameter()/2 - 1, getY() - getDiameter()/2 - 1, getDiameter(), getDiameter());
    switch(_type){
      case 1:
        //Black hole
        lineMax = 12;
        lineMod = 3;
        break;
      case 2:
        //Sol
        lineMax = 60;
        lineMod = 15;
        break;
      case 3:
        //World
        lineMax = 60;
        lineMod = 15;
        break;
      default:
        println("ERR: switch(_type) in drawInterface() defaulted");
        break;
    }

    for(int lineCounter = 1; lineCounter <= lineMax; lineCounter++){
      if (lineCounter%lineMod == 0){
        strokeWeight(3);
      }else{
        strokeWeight(1);
      }
      line(int(getX() + 19*o*sin(TWO_PI*lineCounter/lineMax)/20), int(getY() - 19*o*cos(TWO_PI*lineCounter/lineMax)/20), int(getX() + 21*o*sin(TWO_PI*lineCounter/lineMax)/20), int(getY() - 21*o*cos(TWO_PI*lineCounter/lineMax)/20));
    }
    strokeWeight(1);
  }//End drawInterface()

}//End class Planet
