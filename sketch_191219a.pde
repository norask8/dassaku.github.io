class Boudaisei {
  //field
  int x;
  int y;
  int speedx=5;
  int speedy=5;
  boolean visible;
  PImage gakuseiImage;

  //constructor1
  Boudaisei(int ix, int iy) {
    x=ix;
    y=iy;
    gakuseiImage=loadImage("gakusei.jpg");
  }
  //constructor2
  Boudaisei() {
    x=1100;
    y=650;
    gakuseiImage=loadImage("gakusei.jpg");
  }

  //method
  void output() {
    image(gakuseiImage, x, y, 30, 60);
  }
  void up() {
    y=y-speedy;
    if (y>height||y<0) {
      speedy=-speedy;
    }
  }
  void down() {
    y=y-speedy;
    if (y>height||y<0) {
      speedy=-speedy;
    }
  }
  void right() {
    x=x+speedx;
    if (x>width||x<0) {
      speedx=-speedx;
    }
  }
  void left() {
    x=x-speedx;
    if (x>width||x<0) {
      speedx=-speedx;
    }
  }
  void keyPressed() {
    if (key == CODED) {    
      if (keyCode == RIGHT ) {  
        x+=speedx;
      }
      if (keyCode == LEFT) {
        x-=speedx;
      }
      if (keyCode==UP) {
        y-=speedy;
      }
      if (keyCode==DOWN) {
        y+=speedy;
      }
    }
  }
  boolean isHit(Shuban tanin) {
    if (this.x>tanin.x-35 && this.x<tanin.x+35 && this.y>tanin.y-35 && this.y<tanin.y+35) {
      return true;
    } else {
      return false;
    }
  }
}

class Shuban extends Boudaisei {
  //constructor
  Shuban(int ix, int iy) {
    super();
    gakuseiImage=loadImage("shuban.jpg");
    x=ix;
    y=iy;
  }
}

//instance
Boudaisei dassakun;
Shuban [] mob;
Shuban [] mob2;

int gseq=0;
PImage backgroundImage;


void setup() {
  size(1200, 900);
  dassakun= new Boudaisei();
  mob=new Shuban[8];
  for (int i=0; i<8; i++) {
    mob[i]=new Shuban(100*i, 150);
  }
}

void shortcutKey() {
  if ((keyPressed == true) && (key == '3')) {
    gseq=3;
  }
  if ((keyPressed == true) && (key == '5')) {
    gseq=5;
  }
  if ((keyPressed == true) && (key == '2')) {
    gseq=2;
  }
  if ((keyPressed == true) && (key == '4')) {
    gseq=4;
  }
  if ((keyPressed == true) && (key == '6')) {
    gseq=6;
  }
  if ((keyPressed == true) && (key == '9')) {
    gseq=9;
  }
}

void gameTitle() {
  backgroundImage=loadImage("dassaku.png");
  image(backgroundImage, 0, 0, 1500, 1000);
  textSize(50);
  fill(1, 100, 100);
  text("DASSAKU GAME", 400, height/2);
  text("click to start", 470, height/2+100);
  if (mousePressed) {
    gseq=4;
  }
  shortcutKey();
}

void gameOpening() {
  backgroundImage=loadImage("rouka.jpg");
  image(backgroundImage, 0, 0, 1500, 1000);
  textSize(50);
  fill(1, 100, 100);
  text("Shuban 'A student seemed to escape'", 200, height/2);
  text("Shuban 'Start a search'", 350, height/2+100);
  text("PRESS LEFT KEY", 450, height-100);
  if (key == CODED) {    
    if (keyCode == LEFT) {  
      gseq=1;
    }
  }
}

void gamePlay() {
  textSize(30);
  fill(1, 100, 100);
  text("This floor is 31Co", 800, height/2);
  rect(0, 100, width, 150);
  rect(400, 100, 400, 500);
  rect(0, 600, width, 150);
  rect(400, 20, 400, 80);
  dassakun.output();
  dassakun.keyPressed();
  for (int i=0; i<8; i++) {
    mob[i].output();
    mob[i].right();
  }
  for (int i=0; i<8; i++) {
    if (dassakun.isHit(mob[i])==true) {
      gseq=3;
    }
  }
  if (dassakun.x<=800 && dassakun.x>=400 && dassakun.y<=50) {
    dassakun.x=width/2;
    dassakun.y=750;
    for (int i=0; i<8; i++) {
      mob[i].y=500;
    }
    gseq=5;
  }
  if (dassakun.x>width||dassakun.x<0) {
    gseq=6;
  }
  if (dassakun.y>750) {
    gseq=6;
  }
  if (dassakun.y<100 && dassakun.x<400) {
    gseq=6;
  }
  if (dassakun.y<100 && dassakun.x>800) {
    gseq=6;
  }
  if (dassakun.y<600 && dassakun.x>800 && dassakun.y>220) {
    gseq=6;
  }
  if (dassakun.y<600 && dassakun.x<400 && dassakun.y>220) {
    gseq=6;
  }
}

void gameOver() {
  backgroundImage=loadImage("gakuseisha.jpg");
  image(backgroundImage, 0, 0, 1500, 1000);
  textSize(50);
  fill(1, 100, 100);
  text("GAMEOVER", 400, height/2);
  text("You'll never escape from nda", 250, height-300);
  text("click to retry", 400, height-200);
  if (mousePressed) {
    gseq=0;
    dassakun.x=1100;
    dassakun.y=650;
  }
}

void gameClear() {
  backgroundImage=loadImage("yokochu.jpg");
  image(backgroundImage, 0, 0, 1500, 1000);
  textSize(50);
  fill(1, 100, 100);
  text("GAMECLEAR", 450, height/2);
  text("YOU CAN GET OUT OF NDA", 250, height-50);
  if (mousePressed) {
    gseq=0;
    dassakun.x=1100;
    dassakun.y=650;
  }
}

void gamePlay2() {
  textSize(50);
  fill(1, 100, 100);
  text("Here is 3rd Battalion Shazen", 300, 100);
  rect(0, 300, width, 500);
  dassakun.output();
  dassakun.keyPressed();
  if (dassakun.y<300||dassakun.y>800) {
    gseq=7;
  }
  if (dassakun.x>1200) {
    gseq=8;
    dassakun.x=10;
    dassakun.y=500;
  }
  for (int i=0; i<8; i++) {
    mob[i].output();
    mob[i].right();
    mob[i].down();
    if (mob[i].y<300||mob[i].y>800) {
      mob[i].speedx+=3;
      mob[i].speedx=-mob[i].speedx;
      mob[i].speedy=-mob[i].speedy;
    }
  }
  for (int i=0; i<8; i++) {
    if (dassakun.isHit(mob[i])==true) {
      gseq=3;
    }
  }
  if (dassakun.x<=900&&dassakun.x>=500&&dassakun.y<=20) {
    gseq=2;
  }
}

void gameOver2() {
  backgroundImage=loadImage("rouka.jpg");
  image(backgroundImage, 0, 0, 1500, 1000);
  textSize(50);
  fill(1, 100, 100);
  text("GAMEOVER", 450, height/2-300);
  text("Shuban 'Hey, I heard something over there!'", 50, height/2);
  text("click to retry", 500, height-200);
  if (mousePressed) {
    gseq=0;
    dassakun.x=1100;
    dassakun.y=650;
  }
}

void gameOver3() {
  backgroundImage=loadImage("shazen.jpg");
  image(backgroundImage, 0, 0, 1500, 1000);
  textSize(50);
  fill(1, 100, 100);
  text("GAMEOVER", 450, height/2-300);
  text("Shuban 'Hey, I heard something over there!'", 50, height/2);
  text("click to retry", 500, height-200);
  if (mousePressed) {
    gseq=0;
    dassakun.x=1100;
    dassakun.y=650;
  }
}
void gamePlay3() {
   textSize(50);
  fill(1, 100, 100);
  text("Here is 2nd Battalion Shazen", 300, 100);
  rect(0, 300, width, 500);
  dassakun.output();
  dassakun.keyPressed();
  if (dassakun.y<300||dassakun.y>800) {
    gseq=7;
  }
  if (dassakun.x>1200) {
    gseq=9;
    dassakun.x=10;
    dassakun.y=500;
  }
  for (int i=0; i<8; i++) {
    mob[i].output();
    mob[i].right();
    mob[i].down();
    if (mob[i].y<300||mob[i].y>800) {
      mob[i].speedx+=3;
      mob[i].speedx=-mob[i].speedx;
      mob[i].speedy=-mob[i].speedy;
    }
  }
  for (int i=0; i<8; i++) {
    if (dassakun.isHit(mob[i])==true) {
      gseq=3;
    }
  }
  if (dassakun.x<=900&&dassakun.x>=500&&dassakun.y<=20) {
    gseq=2;
  }
}

void gamePlay4() {
   textSize(50);
  fill(1, 100, 100);
  text("Here is 1st Battalion Shazen", 300, 100);
  rect(0, 300, width, 500);
  dassakun.output();
  dassakun.keyPressed();
  if (dassakun.y<300||dassakun.y>800) {
    gseq=7;
  }
  if (dassakun.x>1200) {
    gseq=2;
    dassakun.x=10;
    dassakun.y=500;
  }
  for (int i=0; i<8; i++) {
    mob[i].output();
    mob[i].right();
    mob[i].down();
    if (mob[i].y<300||mob[i].y>800) {
      mob[i].speedx+=3;
      mob[i].speedx=-mob[i].speedx;
      mob[i].speedy=-mob[i].speedy;
    }
  }
  for (int i=0; i<8; i++) {
    if (dassakun.isHit(mob[i])==true) {
      gseq=3;
    }
  }
  if (dassakun.x<=900&&dassakun.x>=500&&dassakun.y<=20) {
    gseq=2;
  }
}






void draw() {
  background(0);
  if (gseq==0) {
    gameTitle();
  }
  if (gseq==1) {
    gamePlay();
  }
  if (gseq==2) {
    gameClear();
  }
  if (gseq==3) {
    gameOver();
  }
  if (gseq==4) {
    gameOpening();
  }
  if (gseq==5) {
    gamePlay2();
  }
  if (gseq==6) {
    gameOver2();
  }
  if (gseq==7) {
    gameOver3();
  }
  if (gseq==8) {
    gamePlay3();
  }
  if(gseq==9){
    gamePlay4();
  }
}
