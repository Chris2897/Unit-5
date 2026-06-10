void gameover() {
  background(50, 20, 20);
  
  fill(255);
  textSize(50);
  textAlign(CENTER, CENTER);
  
  if (leftScore >= 3) {
    text("LEFT PLAYER WINS!", width / 2, height / 2);
  } else {
    text("RIGHT PLAYER WINS!", width / 2, height / 2);
  }
  
  textSize(20);
  text("Click anywhere to restart", width / 2, height / 2 + 80);
}

void gameoverClicks() {
  mode = INTRO;
}
