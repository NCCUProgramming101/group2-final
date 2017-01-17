class Bullet {
  float shootX;
  float shootY;
  int shootSpeed;
  PImage food0, food1, food2;
  int food, foodSize;
  final int food_0 = 0;
  final int food_1 = 1;
  final int food_2 = 2;


  Bullet(float x, float y) {
    shootX = x;
    shootY = y;
    shootSpeed = 5;
    food = floor(random(3));
    food0 = loadImage("img/food1.png");
    food1 = loadImage("img/food2.png");
    food2 = loadImage("img/food3.png");
    foodSize = 70;
  }

  void display() {
    if (food == 0) {
      food = food_0;
    }
    if (food == 1) {
      food = food_1;
    }
    if (food == 2) {
      food = food_2;
    }
    //ellipse(shootX,shootY,10,10);
    switch(food) {
    case food_0:
      image(food0, shootX, shootY, foodSize, foodSize);
      break;
    case food_1:
      image(food1, shootX, shootY, foodSize, foodSize);

      break;
    case food_2:
      image(food2, shootX, shootY, foodSize, foodSize);

      break;
    }
  }

  void move() {
    shootX += shootSpeed;
  }
}