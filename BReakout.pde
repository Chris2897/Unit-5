int mode;
final int INTRO = 1;
final int GAME = 2;
final int PAUSE = 3;
final int GAMEOVER = 4;

float bottomx, bottomy, bottomd;
float ballx, bally, balld;
float vx,vy;
boolean leftkey,rightkey;

int[] x;
int[] y;





void setup() {
  size(800, 600);
  textAlign (CENTER,CENTER);
  mode = GAME;
  
  bottomx = width/2;
  bottomy = height -40; 
  bottomd = 150;
  
  balld = 20;  
  ballx = width/2;  
  bally = bottomy-30;  
  vx = 4;
  vy = - 4;
  
  x = new int [3];
  y = new int[3];
  
  x [0] = 100;
  y[0] = 100;
  
  x[1] = 400;
  y[1] = 100;
  
  x[2] = 700;
  y[2] = 100;
  
  
  
  
}

void draw() {
  if (mode == INTRO){
    intro();
  } else if (mode == GAME) {
    game();
  } else if (mode == PAUSE) {
    pause();
  } else if (mode == GAMEOVER) {
    gameover();
  } else {
    println("mode error:" + mode);
  }
}
