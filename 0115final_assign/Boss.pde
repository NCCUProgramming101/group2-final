class Boss {
  float x, y, xSpeed, attackX, attackY, imgBossW, imgBossH, attackerW, attackerH;
  PImage imgBoss, attacker;
  boolean isTouched;
  final int button=78;

  Boss() {

    y=160;
    imgBossW=300;
    imgBossH=300;
    x=random(230, width-imgBossW);
    xSpeed=2;
    imgBoss=loadImage("img/boss.png");
    attacker=loadImage("img/enemy0.png");
    attackerW=80;
    attackerH=80;
    isTouched=false;
    attackX=x;
    attackY=y+imgBossH/2;
  }

  void move() {
    x -=xSpeed;
    if (x<=230) {
      println("yes");
      xSpeed*=-1;
    }
    if (x>width-imgBossW) {
      xSpeed*=-1;
    }
  }
  void display() {
    image(imgBoss, x, y, imgBossW, imgBossH);
  }

  void attack() {
    image(attacker, attackX, attackY, attackerW, attackerH);
    attackX -=5;
  }

  boolean isHit(float bx, float by, float bw, float bh) {
    boolean isHitX = this.x+imgBossW >= bx && bx+bw >= this.x;
    boolean isHitY = this.y+imgBossH >= by && by+bh >= this.y; 
    return isHitX && isHitY;
  }
}