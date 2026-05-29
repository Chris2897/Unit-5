import processing.sound.*;

SoundFile successSound;
SoundFile failureSound;
SoundFile backgroundMusic;


String mode = "intro"; 
String targetStyle = "circle"; 

float targetSize = 50;

float targetX, targetY;       
float targetVX = 2;
float targetVY = 2;

int score = 0;
int lives = 3;
int highscore = 0;

float sliderX = 125;
float sliderY = 220;
float sliderWidth = 150;
float sliderValX = 200; 
boolean draggingSlider = false;



void setup() {
  size(400, 400);
  rectMode(CENTER);
  ellipseMode(CENTER);
  
  try {
    successSound = new SoundFile(this, "SUCCESS.wav");
    failureSound = new SoundFile(this, "FAILURE.wav");
    backgroundMusic = new SoundFile(this, "MUSIC.mp3");
    backgroundMusic.loop();
  } catch (Exception e) {
    println("Audio error");
  }
  
  respawnTarget();
}



void draw() {
  background(240, 245, 250); 
  
  if (mode.equals("intro")) {
    fill(44, 62, 80);
    textSize(24);
    textAlign(CENTER, CENTER);
    text("🎯 ULTIMATE CLICKER", width / 2, 100);
    
    if (mouseX > width/2 - 70 && mouseX < width/2 + 70 && mouseY > 200 - 22 && mouseY < 200 + 22) {
      fill(39, 174, 96); 
    } else {
      fill(46, 204, 113); 
    }
    noStroke();
    rect(width / 2, 200, 140, 45, 8); 
    fill(255);
    textSize(14);
    text("PLAY", width / 2, 200);
    
    if (mouseX > width/2 - 70 && mouseX < width/2 + 70 && mouseY > 270 - 22 && mouseY < 270 + 22) {
      fill(41, 128, 185); 
    } else {
      fill(52, 152, 219); 
    }
    noStroke();
    rect(width / 2, 270, 140, 45, 8); 
    fill(255);
    text("OPTIONS", width / 2, 270);
  } 
  
  else if (mode.equals("game")) {
    
    targetX = targetX + targetVX;
    targetY = targetY + targetVY;
    
    if (targetX - targetSize/2 < 0 || targetX + targetSize/2 > width) {
      targetVX = targetVX * -1;
    }
    if (targetY - targetSize/2 < 0 || targetY + targetSize/2 > height) {
      targetVY = targetVY * -1;
    }
    
    fill(127, 140, 141);
    textSize(16);
    textAlign(LEFT, CENTER);
    text("Score: " + str(score), 20, 25);
    text("Lives: " + str(lives), 20, 45);
    
    if (mouseX > 340 - 40 && mouseX < 340 + 40 && mouseY > 30 - 15 && mouseY < 30 + 15) {
      fill(192, 41, 43);
    } else {
      fill(231, 76, 60);
    }
    noStroke();
    rect(340, 30, 80, 30, 8);
    fill(255);
    textSize(14);
    textAlign(CENTER, CENTER);
    text("PAUSE", 340, 30);
    
    stroke(255);
    strokeWeight(2);
    fill(231, 76, 60);
    
    if (targetStyle.equals("circle")) {
      ellipse(targetX, targetY, targetSize, targetSize);
      fill(255);
      ellipse(targetX, targetY, targetSize * 0.6, targetSize * 0.6);
      fill(231, 76, 60);
      ellipse(targetX, targetY, targetSize * 0.2, targetSize * 0.2);
    } else if (targetStyle.equals("square")) {
      rect(targetX, targetY, targetSize, targetSize, 4);
      fill(255);
      rect(targetX, targetY, targetSize * 0.6, targetSize * 0.6, 2);
      fill(231, 76, 60);
      rect(targetX, targetY, targetSize * 0.2, targetSize * 0.2, 0);
    }
  } 
  
  else if (mode.equals("pause")) {
    fill(44, 62, 80);
    textSize(28);
    textAlign(CENTER, CENTER);
    text("GAME PAUSED", width / 2, 150);
    
    if (mouseX > width/2 - 70 && mouseX < width/2 + 70 && mouseY > 240 - 22 && mouseY < 240 + 22) {
      fill(39, 174, 96);
    } else {
      fill(46, 204, 113);
    }
    noStroke();
    rect(width / 2, 240, 140, 45, 8);
    fill(255);
    textSize(14);
    text("RESUME", width / 2, 240);
  }
  
  else if (mode.equals("options")) {
    fill(44, 62, 80);
    textSize(24);
    textAlign(CENTER, CENTER);
    text("OPTIONS MENU", width / 2, 50);
    
    textSize(14);
    text("Select Target Shape:", width / 2, 100);
    
    if (mouseX > 50 - 35 && mouseX < 50 + 35 && mouseY > 30 - 15 && mouseY < 30 + 15) {
      fill(127, 140, 141);
    } else {
      fill(149, 165, 166);
    }
    noStroke();
    rect(50, 30, 70, 30, 8);
    fill(255);
    text("BACK", 50, 30);
    
    if (mouseX > (width/2 - 60) - 45 && mouseX < (width/2 - 60) + 45 && mouseY > 140 - 17 && mouseY < 140 + 17) {
      fill(211, 84, 0);
    } else {
      if (targetStyle.equals("circle")) {
        fill(241, 196, 15); 
      } else {
        fill(189, 195, 199);
      }
    }
    noStroke();
    rect(width / 2 - 60, 140, 90, 35, 8);
    fill(255);
    text("Circle", width / 2 - 60, 140);
    
    if (mouseX > (width/2 + 60) - 45 && mouseX < (width/2 + 60) + 45 && mouseY > 140 - 17 && mouseY < 140 + 17) {
      fill(211, 84, 0);
    } else {
      if (targetStyle.equals("square")) {
        fill(241, 196, 15); 
      } else {
        fill(189, 195, 199);
      }
    }
    noStroke();
    rect(width / 2 + 60, 140, 90, 35, 8);
    fill(255);
    text("Square", width / 2 + 60, 140);
    
    if (draggingSlider) {
      sliderValX = mouseX;
      if (sliderValX < sliderX) sliderValX = sliderX;
      if (sliderValX > sliderX + sliderWidth) sliderValX = sliderX + sliderWidth;
    }
    
    float percentage = (sliderValX - sliderX) / sliderWidth;
    targetSize = 20 + (percentage * 70); 
    
    stroke(189, 195, 199);
    strokeWeight(4);
    line(sliderX, sliderY, sliderX + sliderWidth, sliderY);
    
    noStroke();
    fill(52, 152, 219);
    ellipse(sliderValX, sliderY, 16, 16);
    
    fill(44, 62, 80);
    textSize(14);
    
    String sizeText = "Adjust Target Size: " + str(int(targetSize)) + "px";
    text(sizeText, width / 2, 190);
    text("Preview:", width / 2, 260);
    
    stroke(255);
    strokeWeight(2);
    fill(231, 76, 60);
    if (targetStyle.equals("circle")) {
      ellipse(width / 2, 310, targetSize, targetSize);
      fill(255);
      ellipse(width / 2, 310, targetSize * 0.6, targetSize * 0.6);
      fill(231, 76, 60);
      ellipse(width / 2, 310, targetSize * 0.2, targetSize * 0.2);
    } else if (targetStyle.equals("square")) {
      rect(width / 2, 310, targetSize, targetSize, 4);
      fill(255);
      rect(width / 2, 310, targetSize * 0.6, targetSize * 0.6, 2);
      fill(231, 76, 60);
      rect(width / 2, 310, targetSize * 0.2, targetSize * 0.2, 0);
    }
  }
  
  else if (mode.equals("gameover")) {
    background(52, 73, 94);
    fill(231, 76, 60);
    textSize(36);
    textAlign(CENTER, CENTER);
    text("GAME OVER", width / 2, 120);
    
    fill(255);
    textSize(18);
    text("Your Score: " + str(score), width / 2, 200);
    text("High Score: " + str(highscore), width / 2, 240);
    
    textSize(12);
    fill(149, 165, 166);
    text("Click anywhere to restart", width / 2, 320);
  }
}



void mousePressed() {
  
  if (mode.equals("intro")) {
    if (mouseX > width/2 - 70 && mouseX < width/2 + 70 && mouseY > 200 - 22 && mouseY < 200 + 22) {
      if (successSound != null) successSound.play();
      mode = "game";
    }
    if (mouseX > width/2 - 70 && mouseX < width/2 + 70 && mouseY > 270 - 22 && mouseY < 270 + 22) {
      if (successSound != null) successSound.play();
      mode = "options";
    }
  }
  
  else if (mode.equals("game")) {
    if (mouseX > 340 - 40 && mouseX < 340 + 40 && mouseY > 30 - 15 && mouseY < 30 + 15) {
      if (successSound != null) successSound.play();
      mode = "pause";
      return;
    }
    
    boolean isHit = false;
    if (targetStyle.equals("circle")) {
      float d = dist(mouseX, mouseY, targetX, targetY);
      if (d < targetSize / 2) isHit = true;
    } else if (targetStyle.equals("square")) {
      if (mouseX > targetX - targetSize/2 && mouseX < targetX + targetSize/2 && 
          mouseY > targetY - targetSize/2 && mouseY < targetY + targetSize/2) {
        isHit = true;
      }
    }
    
    if (isHit) {
      score++;
      if (score > highscore) {
        highscore = score;
      }
      
      if (targetVX > 0) {
        targetVX = targetVX + 0.5;
      } else {
        targetVX = targetVX - 0.5;
      }
      
      if (targetVY > 0) {
        targetVY = targetVY + 0.5;
      } else {
        targetVY = targetVY - 0.5;
      }
      
      if (successSound != null) successSound.play(); 
      respawnTarget();
    } else {
      lives = lives - 1;
      if (failureSound != null) failureSound.play();
      if (lives <= 0) {
        mode = "gameover";
      }
    }
  }
  
  else if (mode.equals("pause")) {
    if (mouseX > width/2 - 70 && mouseX < width/2 + 70 && mouseY > 240 - 22 && mouseY < 240 + 22) {
      if (successSound != null) successSound.play();
      mode = "game";
    }
  }
  
  else if (mode.equals("options")) {
    if (mouseX > 50 - 35 && mouseX < 50 + 35 && mouseY > 30 - 15 && mouseY < 30 + 15) {
      if (successSound != null) successSound.play();
      mode = "intro";
    }
    if (mouseX > (width/2 - 60) - 45 && mouseX < (width/2 - 60) + 45 && mouseY > 140 - 17 && mouseY < 140 + 17) {
      if (successSound != null) successSound.play();
      targetStyle = "circle";
    }
    if (mouseX > (width/2 + 60) - 45 && mouseX < (width/2 + 60) + 45 && mouseY > 140 - 17 && mouseY < 140 + 17) {
      if (successSound != null) successSound.play();
      targetStyle = "square";
    }
    if (dist(mouseX, mouseY, sliderValX, sliderY) < 15) {
      draggingSlider = true;
    }
  }
  
  else if (mode.equals("gameover")) {
    score = 0;
    lives = 3;
    targetVX = 2;
    targetVY = 2;
    respawnTarget();
    mode = "intro";
  }
}



void mouseReleased() {
  draggingSlider = false;
}



void respawnTarget() {
  targetX = random(50, width - 50);
  targetY = random(80, height - 50);
}
