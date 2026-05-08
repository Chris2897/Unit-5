
int mode;
 final int INTRO = 0;
final int GAME =  1;
final int PAUSE =  2; 
final int GAMEOVER = 3; 

float x, y, d;

 void setup(){
   size (800,800);
   mode = INTRO;
   textAlign(CENTER, CENTER);
   rectMode (CENTER);
   
   
   
  mode = INTRO;
  x = width/2;
  y = height/2;
  d = 100;
 }
 
 
 void draw(){
   if (mode == INTRO) {
     intro();
   } else if (mode == GAME ) {
     game();
   } else if (mode == PAUSE){
     pause();
   } else if (mode == GAMEOVER ) {
     gameover();
   } else {
     println("Error: Mode = " + mode);
   }
   
   
 }
