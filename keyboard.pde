void keyPressed() {
  if (mode == GAME) {
    if (keyCode == LEFT) leftkey = true;
    if (keyCode == RIGHT) rightkey = true;
  }
}

void keyReleased() {
  if (mode == GAME) {
    if (keyCode == LEFT) leftkey = false;
    if (keyCode == RIGHT) rightkey = false;
  }
}
