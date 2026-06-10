import processing.sound.*;

String mode = "INTRO";

float paddleX;
float paddleY;
float paddleW = 80;
float paddleH = 16;

float ballX;
float ballY;
float ballSpeedX;
float ballSpeedY;
float ballR = 10;

int score;
int lives;

int brickRows = 5;
int brickCols = 8;
float brickR = 20;
int totalBricks = brickRows * brickCols;

float[] brickX = new float[totalBricks];
float[] brickY = new float[totalBricks];
boolean[] brickAlive = new boolean[totalBricks];

color[] brickColors = new color[5];

SoundFile bounceSound;
SoundFile scoreSound;
SoundFile loseSound;
SoundFile winSound;
SoundFile introSound;

void setup() {
  size(800, 600);

  brickColors[0] = color(230, 57, 70);
  brickColors[1] = color(244, 132, 95);
  brickColors[2] = color(244, 211, 94);
  brickColors[3] = color(82, 183, 136);
  brickColors[4] = color(76, 201, 240);

  bounceSound = new SoundFile(this, "bounce.mp3");
  scoreSound = new SoundFile(this, "score.mp3");
  loseSound = new SoundFile(this, "lose.mp3");
  winSound = new SoundFile(this, "SUCCESS.wav");
  introSound = new SoundFile(this, "intro.mp3");

  resetGame();
  introSound.loop();
}

void resetGame() {
  score = 0;
  lives = 3;
  paddleX = width / 2;
  paddleY = height - 40;
  resetBall();
  makeBricks();
}

void resetBall() {
  ballX = width / 2;
  ballY = height - 100;
  ballSpeedX = 4;
  ballSpeedY = -5;
}

void makeBricks() {
  float gapX = 16;
  float gapY = 14;
  float topOffset = 60;
  float totalW = brickCols * (brickR * 2) + (brickCols - 1) * gapX;
  float startX = (width - totalW) / 2 + brickR;

  for (int r = 0; r < brickRows; r++) {
    for (int c = 0; c < brickCols; c++) {
      int i = r * brickCols + c;
      brickX[i] = startX + c * (brickR * 2 + gapX);
      brickY[i] = topOffset + r * (brickR * 2 + gapY);
      brickAlive[i] = true;
    }
  }
}

void draw() {
  if (mode.equals("INTRO")) {
    drawIntro();
  } else if (mode.equals("GAME")) {
    updateGame();
    drawGame();
  } else if (mode.equals("PAUSE")) {
    drawGame();
    drawPause();
  } else if (mode.equals("GAMEOVER")) {
    drawGameOver();
  }
}

void drawIntro() {
  background(10, 10, 30);

  fill(255, 255, 255, 40);
  noStroke();
  for (int i = 0; i < 60; i++) {
    float sx = (i * 137) % width;
    float sy = (i * 97) % height;
    float sr = (i % 3) + 1;
    circle(sx, sy, sr * 2);
  }

  textAlign(CENTER, CENTER);
  textSize(72);
  fill(76, 201, 240);
  text("BREAKOUT!", width / 2, height / 2 - 60);

  textSize(22);
  fill(244, 211, 94);
  text("click to play", width / 2, height / 2 + 30);

  textSize(15);
  fill(180, 180, 255);
  text("move mouse left and right to control paddle", width / 2, height / 2 + 80);
  text("click or press any key during game to pause", width / 2, height / 2 + 105);
}

void updateGame() {
  paddleX = mouseX;
  if (paddleX - paddleW / 2 < 0) {
    paddleX = paddleW / 2;
  }
  if (paddleX + paddleW / 2 > width) {
    paddleX = width - paddleW / 2;
  }

  ballX = ballX + ballSpeedX;
  ballY = ballY + ballSpeedY;

  if (ballX - ballR < 0) {
    ballX = ballR;
    ballSpeedX = abs(ballSpeedX);
    bounceSound.play();
  }
  if (ballX + ballR > width) {
    ballX = width - ballR;
    ballSpeedX = -abs(ballSpeedX);
    bounceSound.play();
  }
  if (ballY - ballR < 0) {
    ballY = ballR;
    ballSpeedY = abs(ballSpeedY);
    bounceSound.play();
  }

  if (ballY + ballR >= paddleY - paddleH / 2 &&
      ballY - ballR <= paddleY + paddleH / 2 &&
      ballX + ballR >= paddleX - paddleW / 2 &&
      ballX - ballR <= paddleX + paddleW / 2 &&
      ballSpeedY > 0) {
    ballSpeedY = -abs(ballSpeedY);
    float hitPos = (ballX - paddleX) / (paddleW / 2);
    ballSpeedX = hitPos * 6;
    bounceSound.play();
  }

  if (ballY - ballR > height) {
    lives = lives - 1;
    loseSound.play();
    if (lives <= 0) {
      mode = "GAMEOVER";
    } else {
      resetBall();
    }
  }

  for (int i = 0; i < totalBricks; i++) {
    if (brickAlive[i] == true) {
      float d = dist(ballX, ballY, brickX[i], brickY[i]);
      if (d < ballR + brickR) {
        brickAlive[i] = false;
        score = score + 1;
        scoreSound.play();

        float dx = ballX - brickX[i];
        float dy = ballY - brickY[i];
        if (abs(dx) > abs(dy)) {
          ballSpeedX = -ballSpeedX;
        } else {
          ballSpeedY = -ballSpeedY;
        }
      }
    }
  }

  boolean allGone = true;
  for (int j = 0; j < totalBricks; j++) {
    if (brickAlive[j] == true) {
      allGone = false;
    }
  }
  if (allGone) {
    winSound.play();
    mode = "GAMEOVER";
  }
}

void drawGame() {
  background(13, 13, 43);

  for (int r = 0; r < brickRows; r++) {
    for (int c = 0; c < brickCols; c++) {
      int i = r * brickCols + c;
      if (brickAlive[i] == true) {
        noStroke();
        fill(brickColors[r]);
        circle(brickX[i], brickY[i], brickR * 2);
      }
    }
  }

  fill(76, 201, 240);
  noStroke();
  rect(paddleX - paddleW / 2, paddleY - paddleH / 2, paddleW, paddleH, 8);

  fill(255);
  noStroke();
  circle(ballX, ballY, ballR * 2);

  textAlign(LEFT, BOTTOM);
  textSize(20);
  fill(244, 211, 94);
  text("Score: " + score, 20, height - 10);

  textAlign(RIGHT, BOTTOM);
  fill(230, 57, 70);
  text("Lives: " + lives, width - 20, height - 10);
}

void drawPause() {
  fill(0, 0, 0, 160);
  noStroke();
  rect(0, 0, width, height);

  textAlign(CENTER, CENTER);
  textSize(72);
  fill(244, 211, 94);
  text("PAUSED", width / 2, height / 2 - 40);

  textSize(22);
  fill(76, 201, 240);
  text("click to resume", width / 2, height / 2 + 40);
}

void drawGameOver() {
  background(10, 10, 30);

  fill(255, 255, 255, 40);
  noStroke();
  for (int i = 0; i < 60; i++) {
    float sx = (i * 137) % width;
    float sy = (i * 97) % height;
    float sr = (i % 3) + 1;
    circle(sx, sy, sr * 2);
  }

  textAlign(CENTER, CENTER);

  if (score >= totalBricks) {
    textSize(72);
    fill(82, 183, 136);
    text("YOU WON!", width / 2, height / 2 - 60);
  } else {
    textSize(72);
    fill(230, 57, 70);
    text("YOU LOST!", width / 2, height / 2 - 60);
  }

  textSize(22);
  fill(244, 211, 94);
  text("Final Score: " + score, width / 2, height / 2 + 10);

  textSize(20);
  fill(76, 201, 240);
  text("click to restart", width / 2, height / 2 + 60);
}

void mouseClicked() {
  if (mode.equals("INTRO")) {
    mode = "GAME";
    introSound.stop();
  } else if (mode.equals("GAME")) {
    mode = "PAUSE";
  } else if (mode.equals("PAUSE")) {
    mode = "GAME";
  } else if (mode.equals("GAMEOVER")) {
    resetGame();
    mode = "INTRO";
    introSound.loop();
  }
}

void keyPressed() {
  if (mode.equals("GAME")) {
    mode = "PAUSE";
  } else if (mode.equals("PAUSE")) {
    mode = "GAME";
  }
}
