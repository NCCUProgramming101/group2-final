import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

int gameState = 0;

final int start = 0;
final int play1 = 1;
final int play2 = 2;
final int win   = 3;
final int lose = 4;

final int info11=5;
final int info22=6;
final int item1=7;

final int button=78;
final int humanH=80;

boolean flyOut;
import ddf.minim.*;

PImage bg1, bg2, bg3, move1, move2, end_win, end_lose,item,info1,info2;
int bgR = 0;
int score = 0;
float menHp,menHp1;
int bossHp;
PFont f;
boolean upPressed=false;

Food foods[];
Enemy enemies[];
BossAttack bossAttack;
Joe joe;
Boss boss;
HPBar hpBar;

//bullet
boolean spacePressed = false;
int shootCount = 200;
Bullet[] shootArray = new Bullet[shootCount];

Minim minim;
AudioPlayer song;
AudioPlayer bossSong;
AudioPlayer winSong;
AudioPlayer loseSong;
AudioSample hit;
AudioSample getPoint;


void setup() {
  size(640, 480);
  bg1 = loadImage("img/bg1.jpg");
  bg2 = loadImage("img/bg2.jpg");
  bg3 = loadImage("img/bg3.jpg");
  move1 = loadImage("img/move1.jpg");
  move2 = loadImage("img/move2.jpg");
  end_win = loadImage("img/end_win.jpg");
  end_lose = loadImage("img/end_lose.jpg");
  item=loadImage("img/item.png");
  info1=loadImage("img/info1.png");
  info2=loadImage("img/info2.png");
  foods = new Food[3];
  enemies=new Enemy[3];
  bossAttack = new BossAttack("enemy0");
  bossAttack = new BossAttack("enemy1");
  bossAttack = new BossAttack("enemy2");
  joe = new Joe();
  boss = new Boss(); 
  hpBar = new HPBar();
  menHp = 100;
  menHp1=200;
  bossHp = 200;
  shootArray = new Bullet[shootCount];

  
  minim = new Minim(this);
  song = minim.loadFile("music/background music1.mp3");
  bossSong = minim.loadFile("music/background music2.mp3");
  winSong = minim.loadFile("music/winSong.mp3");
  loseSong = minim.loadFile("music/loseSong.mp3");
  hit = minim.loadSample("music/hit.mp3");
  getPoint = minim.loadSample("music/getpoint.mp3");
  song.loop();
  song.play();
  
  f= createFont("Arial", 24);
  flyOut = false;
  for (int i=0; i<3; i++) {
    enemies[i] = new Enemy("enemy"+i);
  }
  for (int i=0; i<3; i++) {
    enemies[i] = new Enemy("enemy"+i);
  }
  for (int i=0; i<3; i++) {
    switch(floor(random(3))) {
    case 0:
      foods[i]= new Shrimp ();
      break;
    case 1:
      foods[i]=new Pancake();
      break;
    case 2:
      foods[i]=new Drink();
      break;
    }
  }
}

void draw() {
 
  switch(gameState) {
     case info11:
    image(info1,0,0,640,480);
    
    
  if (mouseX>0 &&mouseX<20&& mouseY>0&& mouseY<20) {
      if (mousePressed) {
      gameState=info22;
      }
    }
    break;
   case info22:
   image(info2,0,0,640,480);
   if (mouseX>20 &&mouseX<40&& mouseY>20&& mouseY<40) {
      if (mousePressed) {
      gameState=item1;
      }
  }
  break;
  
  case item1:
  image(item,0,0,640,480);
  if (mouseX>40 &&mouseX<60&& mouseY>40&& mouseY<60) {
      if (mousePressed) {
      gameState=start;
      }
  }
  break;
  case start:
    if (mouseX >= 231 && mouseX <= 406 && mouseY >= 203 && mouseY <= 276) {
      image(bg2, 0, 0, 640, 480);
      if (mousePressed) {              
        gameState = play1;
      }
    } else {
      image(bg1, 0, 0, 640, 480);
    }       
    break;

  case play1:

    bgmoving();
    
    
    for (int i=0; i<3; i++) {
      foods[i].fly();
      foods[i].display();
      enemies[i].fly();
      enemies[i].display();
      if (foods[i].isHit(joe.fighterX2, joe.fighterY+10, joe.fighterW, joe.fighterH)) {
        menHp += 10;
        score += 20;
        foods[i].x = random(foods[i].x+foods[i].w, width-foods[i].w);
        foods[i].y = 0;
        foods[i].flyOut = true;
        getPoint.trigger();
      }
       if (foods[i].isHit(joe.fighterX, joe.fighterY+10, joe.fighterW, joe.fighterH)) {
        menHp += 10;
        score += 20;
        foods[i].x = random(foods[i].x+foods[i].w, width-foods[i].w);
        foods[i].y = 0;
        foods[i].flyOut = true;
        getPoint.trigger();
      }
     
    if (enemies[i].isHit(joe.fighterX, joe.fighterY+10, joe.fighterW, joe.fighterH)) {
      menHp -= 10;
      score -=10;
      enemies[i].y=-200;
      enemies[i].x=random(width/2, width-enemies[i].w);
      hit.trigger();
    }
    if(upPressed){
    if (enemies[i].isHit(joe.fighterX2, joe.jumpingHeight+10, joe.jumpingW, joe.jumpingH) ) {
      menHp -= 10;
      score -=10;
      enemies[i].y=-200;
      enemies[i].x=random(width/2, width-enemies[i].w);
      hit.trigger();
    }
    }
    }

    joe.display();
    //joe.joePosition();
    joe.smash();
    joe.jump();

    hpBar.display(menHp);
    if (menHp >= 200) {
      menHp = 200;
    }
    if (menHp <= 0) {
      gameState=lose;
    }
    textFont(f, 20);
    textAlign(CENTER);
    fill(255);
    text("Score:"+score, 580, 465);
    
    if(score >= 100){
      
      gameState = play2;
    }
    
    break;

  case play2:
    image(bg3, 0, 0);
    
    
    //bossSong.loop();
    //bossSong.play(); 
    //song.close();
    boss.display();
    boss.move();
    bossAttack.move();
    bossAttack.display();
     if(bossAttack.touchHuman(joe.fighterX,joe.fighterY,joe.fighterW-50, joe.fighterH)){
     menHp1 -= 20;
     bossAttack.attackY=-100;;
     hit.trigger();
      }
        if(upPressed){
       if(bossAttack.touchHuman(joe.fighterX2,joe.jumpingHeight,joe.jumpingW-50, joe.jumpingH)){
     menHp1 -= 20;
     bossAttack.attackY=-100;;
     hit.trigger();
      }
        }

    joe.display();
    
    joe.smash();
    joe.jump();
    if (spacePressed) {
      spacePressed = false;
      for (int i = 0; i<shootArray.length; i++) {
        if (shootArray[i] == null || shootArray[i].shootX >= width) {
          shootArray[i] = new Bullet(joe.fighterX+40, joe.fighterY+10); 
          break;
        }
      }
    }
    for (int i=0; i<200; i++) {
      if (shootArray[i] == null) continue;
      shootArray[i].display();
      shootArray[i].move();
      if(boss.isHit(shootArray[i].shootX-50, shootArray[i].shootY, shootArray[i].foodSize, shootArray[i].foodSize)){
        bossHp -= 5;
        shootArray[i].shootY=-100;
        getPoint.trigger();
      }
      //if out of the screen
      if (shootArray[i].shootX + 20 >width) {
        shootArray[i].shootX = 0-20;
        shootArray[i].shootY = height+1;
      }
    }

    hpBar.display(bossHp);
    if(bossHp >= 250){
      bossHp = 250;
    }if(bossHp <= 0){
      gameState = win;
      
    }

    hpBar.display(menHp1);
    if(menHp1 <= 0){
      gameState = lose;
      //bossSong.close();
    }
    
    if (menHp1 >= 200) {
      menHp1 = 200;
    }
    break;

  case win:
    //song.close();
    //winSong.loop();
    //winSong.play();
    
     
    image(end_win, 0, 0);
    
    if (mouseX>0 &&mouseX<640&& mouseY>0&& mouseY<480) {
      if (mousePressed) {
        song.play();
        song.loop();
        
        gameState = start;
        reStart();
        
        //winSong.close();
      }
    }
    break;

  case lose:
    //loseSong.loop();
    //loseSong.play();
    //song.close();
    
   
    image(end_lose, 0, 0);
    if (mouseX>0 &&mouseX<640&& mouseY>0&& mouseY<480) {
      if (mousePressed) {
        //loseSong.close();
        song.play();
        song.loop();
        gameState = start;
        reStart();
        
        
      }
    }
    break;
  }
}

boolean isHit(int ax, int ay, int aw, int ah, int bx, int by, int bw, int bh) {
  boolean collisionX = (ax + aw >= bx) && (bx + bw >= ax);
  boolean collisionY = (ay + ah >= by) && (by + bh >= ay);
  return collisionX && collisionY;
}

void bgmoving() {
  image(move1, bgR, 0);
  image(move2, bgR+640, 0);
  image(move1, bgR+1280, 0);
  bgR = bgR - 2;
  bgR = bgR % 1280;
}

void reStart() {
  song.loop();
  song.play();
  foods = new Food[3];
 
  for (int i=0; i<3; i++) {
    enemies[i] = new Enemy("enemy"+i);
  }
  bossAttack = new BossAttack("enemy0");
  bossAttack = new BossAttack("enemy1");
  bossAttack = new BossAttack("enemy2");
  joe = new Joe();
  boss = new Boss(); 
  hpBar = new HPBar();
  menHp = 100;
  menHp1=200;
  bossHp = 200;
  score = 0;
  shootArray = new Bullet[shootCount];
  flyOut = false;
  
  for (int i=0; i<3; i++) {
    switch(floor(random(3))) {
    case 0:
      foods[i]= new Shrimp ();
      break;
    case 1:
      foods[i]=new Pancake();
      break;
    case 2:
      foods[i]=new Drink();
      break;
    }
  }
}

void keyPressed() {
  joe.KeyPressed();
  joe.joePosition();
  if (key == ' ') {
    spacePressed = true;
    //println(spacePressed);
  }
}

void keyReleased() {
  joe.KeyReleased();
  if (key == ' ') {
    spacePressed = false;
  }
}