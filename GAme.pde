void game() {
  background(0);  
  
  circle (x[0],y[0],100);
   circle (x[1],y[1],100);
    circle (x[2],y[2],100);
  
  
  
  
  
  
  
  if (leftkey == true) bottomx = bottomx - 8;
  if (rightkey == true) bottomx = bottomx + 8;
  
  rectMode(CENTER);
  fill(255);
  circle(bottomx, bottomy, bottomd);
  
  fill(255, 0, 0);  
  ellipse(ballx, bally, balld, balld);
  
 
  ballx = ballx + vx;
  bally = bally + vy;
  
  
  if (ballx - balld/2 < 0) {
    ballx = balld/2;
    vx = vx * -1;
  }
  if (ballx + balld/2 > width) {
    ballx = width - balld/2;
    vx = vx * -1;
  }
  if (bally - balld/2 < 0) {
    bally = balld/2;
    vy = vy * -1;
  }
  
 
 
if (dist(ballx, bally, bottomx, bottomy) < balld/2 + bottomd/2) {
    vx = (ballx - bottomx)/10;
    vy = (bally - bottomy)/10;
}
  

  if (bally + balld/2 > height) {
    mode = GAMEOVER;
  }
  
 
  if (bottomx - bottomd/2 < 0) bottomx = bottomd/2;
  if (bottomx + bottomd/2 > width) bottomx = width - bottomd/2;
}





void gameClicks()  {
  
  
}
