class HPBar {
  int x, y ;
  float hpBar;
  PImage img;

  HPBar () {
    x = 0;
    y = 0;
    img = loadImage("img/hp.png");
  }

  void display(int bossHp) {
    stroke(165, 32, 2);
    fill(252, 252, 190);
    rect(width-250, 5, 250, 15); 
    fill(255, 0, 0);
    rect(width-bossHp-20, 5, 245, 15);
  }
  void display(float menHp) {

    stroke(165, 32, 2);
    fill(26, 202, 190);
    rect(x, y+5, 200, 15); 
    fill(255, 0, 0);
    rect(x, y+5, menHp, 15);
  }
}