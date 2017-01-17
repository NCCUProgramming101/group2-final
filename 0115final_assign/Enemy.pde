class Enemy {
  float x, y, xSpeed=3, ySpeed=3.5;
  float w, h, size;
  PImage img;
  boolean flyOut;
  
  Enemy(String filename) {
    flyOut = false;
    filename = "img/"+filename+".png";
    img = loadImage(filename);
    x = random(width-200, width-w);
    w=80;
    h=80;
  }
  
  boolean isHit(int bx, int by, int bw, int bh) {
    boolean isHitX = this.x+this.w >= bx && bx+bw >= this.x;
    boolean isHitY = this.y+this.h >= by && by+bh >= this.y; 
    return isHitX && isHitY;
  }
  
  void fly() {
    x -= xSpeed;
    y += ySpeed;
    ySpeed *= 0.99;
    int i = floor(random(3));
    if (y>480||x+w<0) {
      y=0;
      x=random(width/2, width-w);
      ySpeed=3.5;
      flyOut = true;
      i = floor(random(3));
      img = loadImage("img/enemy"+i+".png");
    }
  }
  
  void display() {
    image(img, x, y, 80, 80);
  }
}