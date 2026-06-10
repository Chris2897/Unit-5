void game() {
  background(20, 40, 20);
  
  stroke(255, 100);
  strokeWeight(4);
  line(width / 2, 0, width / 2, height);
  
  fill(255);
  textSize(40);
  textAlign(CENTER, CENTER);
  text(leftScore, width / 4, 50);
  text(rightScore, 3 * width / 4, 50);
  
  noStroke();
  fill(255, 200, 50);
  circle(leftX, leftY, leftD);
  
  fill(255, 50, 100);
  circle(rightX, rightY, rightD);
  
  fill(255);
  circle(ballX, ballY, ballD);
  
  if (wKey && leftY > leftD / 2) {
    leftY -= 5;
  }
  if (sKey && leftY < height - leftD / 2) {
    leftY += 5;
  }
  
  if (isSinglePlayer) {
    if (ballY < rightY && rightY > rightD / 2) {
      rightY -= 3.8;
    }
    if (ballY > rightY && rightY < height - rightD / 2) {
      rightY += 3.8;
    }
  } else {
    if (upKey && rightY > rightD / 2) {
      rightY -= 5;
    }
    if (downKey && rightY < height - rightD / 2) {
      rightY += 5;
    }
  }
  
  if (timer > 0) {
    timer--;
  } else {
    ballX += ballVX;
    ballY += ballVY;
  }
  
  if (ballY - ballD / 2 < 0 || ballY + ballD / 2 > height) {
    ballVY = -ballVY;
  }
  
  if (dist(ballX, ballY, leftX, leftY) < ballD / 2 + leftD / 2) {
    ballVX = (ballX - leftX) * 0.1;
    ballVY = (ballY - leftY) * 0.1;
  }
  
  if (dist(ballX, ballY, rightX, rightY) < ballD / 2 + rightD / 2) {
    ballVX = (ballX - rightX) * 0.1;
    ballVY = (ballY - rightY) * 0.1;
  }
  
  if (ballX < 0) {
    rightScore++;
    if (rightScore >= 3) {
      mode = GAMEOVER;
    } else {
      resetGame();
    }
  }
  
  if (ballX > width) {
    leftScore++;
    if (leftScore >= 3) {
      mode = GAMEOVER;
    } else {
      resetGame();
    }
  }
}

void gameClicks() {
  mode = PAUSE;
}
