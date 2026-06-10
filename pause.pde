void pause() {
  fill(0, 10);
  rect(0, 0, width, height);
  
  fill(255);
  textSize(50);
  textAlign(CENTER, CENTER);
  text("PAUSED", width / 2, height / 2);
}

void pauseClicks() {
  mode = GAME;
}
