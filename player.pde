//Implement some movement for the characters hat.
//Have the hat rise quicker, but fall in time for the characters landing
//The hat needs to jump independently of the main jump, but start at the same time as the characters jump.

//Maybe have a dust cluster appear upon character landing to appear more animated.
//This could be achieved in a similar way to the jumping algorithym


class player{
 //Variables to control jumping
 public boolean jumping = false;//So jumps can't stack
 private float verticalSpeed = 0;
 private final float gravity = 0.9;//Strength of gravity

 private float h = 100;
 private float levelHeight = 500-h-35;
 private float y = levelHeight;
 private float w = 50;
 
  //Further variables for the hat gravity
 private boolean hatJumping = false;
 private float hatVerticalSpeed = 0;
 private final float hatGravity = 0.9;
 
 private float hatH = 50;
 private float hatLevelHeight = 500-h-20-hatH;
 private float hatY = hatLevelHeight;
 private float hatW = 100;
 
 
 PImage playerSprite;
 PImage playerHat;
 
 public player(){playerSprite = loadImage("playerSprite.png");playerHat = loadImage("playerHat.png");}
 
 public void draw(){
   fill(0);
   image(playerSprite,50,y,w,h);
   image(playerHat,25,hatY,hatW,hatH);
   gravity();
 }
 
 public void jump(){
   if(!jumping){
     jumping = true;
     verticalSpeed = -18;
     hatJumping = true;
     hatVerticalSpeed = -19;
   }
 }
 
 private void gravity(){//change vertical speed according to gravity
   
 
   if(jumping){  //If the player is still in the air, keep imposing gravity on the player
     verticalSpeed += gravity;
     y += verticalSpeed;
   }
   if(hatJumping){//Do the same with the hat physics
     hatVerticalSpeed += hatGravity;
     hatY += hatVerticalSpeed;
   }
   
   if(jumping && y > levelHeight){ //If the player hit the ground, stop dropping
     jumping = false;
     y = levelHeight;
     verticalSpeed = 0;
   }
   if(hatJumping && hatY > hatLevelHeight){//Do the same with the hat
     hatJumping = false;
     hatY = hatLevelHeight;
     hatVerticalSpeed = 0;
   }
  }
  
  public float getY(){return y;}
  public float getH(){return h;}
  public float getW(){return w;}
}