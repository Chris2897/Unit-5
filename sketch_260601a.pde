int mode;
final int INTRO = 1;
final int GAME = 2;
final int PAUSE = 3;
final int GAMEOVER = 4;

float ballX, ballY, ballD, ballVX, ballVY;
float leftX, leftY, leftD;
float rightX, rightY, rightD;

boolean wKey, sKey, upKey, downKey;
boolean isSinglePlayer;

int leftScore, rightScore;
int timer;

void setup() {
  size(800, 600);
  mode = INTRO;
  
  ballD = 30;
  leftD = 100;
  rightD = 100;
  
  resetGame();
}

void draw() {
  if (mode == INTRO) {
    intro();
  } else if (mode == GAME) {
    game();
  } else if (mode == PAUSE) {
    pause();
  } else if (mode == GAMEOVER) {
    gameover();
  } else {
    println("Mode Error: " + mode);
  }
}

void resetGame() {
  ballX = width / 2;
  ballY = height / 2;
  
  float angle = random(-PI/4, PI/4);
  if (random(1) > 0.5) {
    angle += PI;
  }
  ballVX = cos(angle) * 5;
  ballVY = sin(angle) * 5;
  
  leftX = 50;
  leftY = height / 2;
  rightX = width - 50;
  rightY = height / 2;
  
  timer = 100;
}

void resetMatch() {
  leftScore = 0;
  rightScore = 0;
  resetGame();
}
