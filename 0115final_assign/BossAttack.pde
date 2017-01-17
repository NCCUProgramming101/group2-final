class BossAttack extends Boss{
  PImage attacker;
  float attackX, attackY, attackSpeed;
  float attackW, attackH;
  
  BossAttack(String filename){
    filename = "img/"+filename+".png";
    attacker = loadImage(filename);
    attackW = 80;
    attackH = 80;
    attackX = x;
    attackY = 202 + 100;  //y + imgBossH/2
    attackSpeed = 3;
  }
  void move(){
    attackX -= attackSpeed;
    if(attackX <= -attackW){
      attackY = -5;
      int i = floor(random(3));
      attacker = loadImage("img/enemy"+i+".png");
      attackX=x;
      attackY = 202 + 100;
    } 
   
  }
 void display(){
   image(attacker,attackX,attackY,attackW,attackH);
   
 }
  boolean touchHuman(int bx, int by, int bw, int bh) {
    boolean touchHumanX = attackX+attackW >= bx && bx+bw >= attackX;
    boolean touchHumanY = attackY+attackH >= by && by+bh >= attackY; 
    return touchHumanX && touchHumanY;
  }
}