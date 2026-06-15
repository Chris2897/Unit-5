void game() {
  background(0);
  circle (leftx,lefty,leftd);
  circle(rightx,righty,rightd);
  
  
  if (wkey == true) lefty = lefty - 5;
  if (skey == true )lefty = lefty + 5;
  if (upkey == true) righty = righty - 5;
  if (downkey == true) righty = righty + 5;
  fill(225);
  stroke(225,0,0);
  strokeWeight(4);
  if (bally<=balld/2 || bally>=height-balld/2) {
    vy = vy*-1;
  }
  
  if (dist(ballx,bally,rightx,righty) < balld/2 + rightd) {
    vx = (ballx - rightx)/10;
    vy = (bally-righty)/10;
  }
if (dist(ballx,bally,leftx,lefty) < balld/2 + leftd) {
  vx = (ballx-leftx)/10;
  vy = (bally-lefty)/10;
}
  
   if (ballx< 0) {
     rightscore = rightscore + 1;
     
   }
  
   if (lefty - leftd/2 < 0) lefty = leftd/2;
  if (lefty + leftd/2 > height) lefty = height - leftd/2;
  if (righty - rightd/2 < 0) righty = rightd/2;
  if (righty + rightd/2 > height) righty = height - rightd/2;
  
  
  
  
  
  
  
  strokeWeight(5);
  stroke(255);
  line(width/2,0,width/2,height);
  
  textSize(50);
  fill(0,255,0);
  text(leftscore,width/4,100);
  fill(255,0,0);
  text(rightscore,3*width/4,100);
  
  
  
  
  
  circle(ballx,bally,balld);
  
 ballx = ballx + vx;
bally = bally + vy;



if(bally < balld/2 || bally > height - balld/2){
  vy = vy * -1;
}
  
}


void gameClicks(){
  
}
