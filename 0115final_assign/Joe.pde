class Joe {

  int fighterW, fighterH, jumpingW, jumpingH, jumpingHeight;
  int fighterX, fighterY, fighterX2, fighterY2;
  int fighterSpeed;
  boolean upPressed, downPressed, leftPressed, rightPressed;



  PImage fighter, fighterSmash, fighterJump;

  Joe() {
    fighter = loadImage("img/fighter.png");
    fighterSmash = loadImage("img/fighterSmash.png"); 
    fighterJump = loadImage("img/fighterJump.png");
    fighterW = fighterH = 100;
    upPressed = false;
    downPressed = false; 
    leftPressed=false;
    rightPressed=false;
    //fighterY2 = fighterH;
    fighterX2 = 60;
    fighterY = 200;
    fighterX = 60;
    jumpingW = 100;
    jumpingH = 100;
    jumpingHeight = 290;
    fighterSpeed=6;
  }
  void display() {
    image(fighter, fighterX, fighterY, fighterW, fighterH);
  }


  void jump() {
    if (upPressed) {
      image(fighterJump, fighterX2, jumpingHeight, jumpingW, jumpingH);
      fighterX = 1000;
    } else if (upPressed == false) {
      fighterX = 60;
    }
  }



  void smash() {
    if (downPressed) {

      image(fighterSmash, fighterX, 380, fighterW, fighterH);
      fighterY = 1000;
    }
    if (downPressed == false) {
      fighterY = 360;
    }
  }

  void joePosition() {
    if (leftPressed) {
      println("true");
      fighterX -=fighterSpeed;
    }
    if (rightPressed) {
      fighterX +=fighterSpeed;
    }
  }



  void KeyPressed() {
    if (key == CODED) {
      switch(keyCode) {
      case UP:
        upPressed = true;
        break;
      case DOWN:
        downPressed = true;
        break;
      case LEFT:
        leftPressed = true;
        break;
      case RIGHT:
        rightPressed = true;
        break;
      }
    }
  }

  void KeyReleased() {
    if (key == CODED) {
      switch(keyCode) {
      case UP:
        upPressed = false;
        break;
      case DOWN:
        downPressed = false;
        break;
      case LEFT:
        leftPressed = false;
        break;
      case RIGHT:
        rightPressed = false;
        break;
      }
    }
  }
}