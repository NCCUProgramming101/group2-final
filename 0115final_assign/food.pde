class Food{
  float x,y,xSpeed,ySpeed;
  float w,h,size;
  int foodType;
  boolean flyOut;
  boolean touchHuman;
  int value;
  int textX,textY;
  
  //private 
  float touchX,touchY;
  PImage img;
  
  Food (String filename){
    touchHuman = false;
    flyOut = false;
    foodType = floor(random(2));
    filename = "img/"+filename+".png";
    img = loadImage(filename);
    x = random(x+w,width-w);
    y = 0;
    xSpeed = 3;
    ySpeed = 3.6;
    value = 0;
    w = 80;
    h = 80;
    
  }
  
  void fly(){
     x -= xSpeed;
     y += ySpeed;
     y *= 0.99;
     if(y>=480-button ||x+img.width<0){
       y = -5;
       x = random(width);
       flyOut = true;
       int i = floor(random(3)+1);
       img = loadImage("img/food"+i+".png");
     }
  }
  
  void display(){
    image(img,this.x,y,w,h);    
  }

  boolean isHit(int bx, int by, int bw, int bh) {
    boolean isHitX = this.x+this.w >= bx && bx+bw >= this.x;
    boolean isHitY = this.y+this.h >= by && by+bh >= this.y; 
    return isHitX && isHitY;
  }
 
}