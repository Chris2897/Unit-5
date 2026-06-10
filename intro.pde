void intro() {
  background(20, 30, 50);
  
  textAlign(CENTER, CENTER);
  fill(255);
  textSize(60);
  text("PONG", width / 2, 150);
  
  stroke(255);
  if (mouseX > 200 && mouseX < 400 && mouseY > 350 && mouseY < 430) {
    fill(100, 150, 255);
  } else {
    fill(50, 80, 150);
  }
  rect(200, 350, 200, 80, 10);
  
  if (mouseX > 450 && mouseX < 650 && mouseY > 350 && mouseY < 430) {
    fill(100, 150, 255);
  } else {
    fill(50, 80, 150);
  }
  rect(450, 350, 200, 80, 10);
  
  fill(255);
  textSize(20);
  text("1 PLAYER", 300, 390);
  text("2 PLAYER", 550, 390);
}

void introClicks() {
  if (mouseX > 200 && mouseX < 400 && mouseY > 350 && mouseY < 430) {
    isSinglePlayer = true;
    resetMatch();
    mode = GAME;
  }
  if (mouseX > 450 && mouseX < 650 && mouseY > 350 && mouseY < 430) {
    isSinglePlayer = false;
    resetMatch();
    mode = GAME;
  }
}
