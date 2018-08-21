boolean gameStarted = false;
boolean gameEnded = false;
int score = 0;
int hiscore;
boolean newHiscore = false;
PFont scoreFont;
PFont titleFont;
PFont subtitleFont;

//The player
player p;

//Environment variables
int environmentDensity = 8;
cloud[] clouds = new cloud[environmentDensity];
rock[] rocks = new rock[environmentDensity];
public int groundOffset = 35;  //Determines how far off the bottom of the screen the "ground" is.
public static float startSpeed;
public static float speedIncrement;

//Obstacle/s
Obstacle[] obstacles = new Obstacle[2];

/////////////////////////////////////////////////////////////////////////////////////////////////////////
void setup(){
  size(1500,500);
  
  p = new player();
  hiscore = parseInt(loadStrings("hiscore.mlg")[0]);
  print(hiscore);
  
  obstacles[0] = new Obstacle(width + 1000);
  obstacles[1] = new Obstacle(width + 1700);
  
  scoreFont = createFont("Agency FB",48,true);
  titleFont = createFont("Agency FB",100,true);
  subtitleFont = createFont("Agency FB",60,true);
  
  for(int i=0;i<environmentDensity;i++){
    clouds[i] = new cloud();
    rocks[i] = new rock();
  }
}

void draw(){
  background(20,100,225);
  //Draw the sun
  fill(218, 229, 4,200);
  rect(50,50,100,100);
  fill(229, 172, 4);
  rect(65,65,70,70);
  fill(229, 124, 4);
  rect(75,75,50,50);
  //Draw the ground
  fill(196, 120, 92);
  rect(0,350,width,height-350);
  //Draw the scrolling environment
  for(int i=0;i<environmentDensity;i++){
    clouds[i].draw();
    rocks[i].draw();
  }
  
  if(gameStarted){
    spawnCalculator.speedCalculatorTick(); //Process the speed calculation of all ground based objects.
    p.draw();
    
    //Manage the obstacles
    for(Obstacle ob : obstacles){
      ob.draw();
      //Check if we hit the obstacle
      if(ob.isHit(p.getY(),p.getH(),p.getW())){
        endGame();
      }
    }
    
    if(gameEnded){//Draw the end screen if the game is finished
        fill(255,200,200,200);
        rect(0,0,width,height);
        fill(255,50,50);
        textFont(titleFont);
        text("GAME OVER",200,200);
        textFont(subtitleFont);
        text("Press [r] to play again.",200,300);
        if(newHiscore){//Save this new hiscore
          text("[New Best!]",600,180);
          saveStrings("hiscore.mlg",new String[] {String.format("%d",hiscore)});
        }
    }else{
      score++;
      if(score > hiscore){
        newHiscore = true;
        hiscore = score;
      }
    }
    
    
    fill(0);
    textFont(scoreFont);
    if(score<hiscore){
      text("Score:  "+score,1200,40);
      text("Best:    "+hiscore,1200,80);
    }else{
      text("Best:    "+score,1200,40);
    }
  }else{//Draw a menu when the game isn't started
  fill(255);
  textFont(titleFont);
  text("Infinirun",200,200);
  for(int i=0;i<10;i++){//Fade the title across the screen
    fill(255,255,255,255-20*i);
    text(".",450+20*(i+1),200);
  }
  textFont(subtitleFont);
  text("Press [r] to start.",200,300);
  }
  
  
}

void endGame(){
  gameEnded = true;
  //Stop the obstacles moving
  spawnCalculator.stopObjects();
  //Stop the background scrolling.
  for(cloud c : clouds){
    c.stop();
  }
}

void keyPressed(){
  if(key==' '){
    if(!p.jumping && !gameEnded){
      p.jump();
    }
  }
  else if(key == 'r'){
    if(!gameStarted){
      spawnCalculator.startObjects();
      gameStarted = true;
    }
    if(gameEnded){
      //reset the game and start again
      score=0;
      newHiscore = false;
      gameEnded = false;
      spawnCalculator.restartObjects();
      for(Obstacle ob : obstacles){
        ob.reset();
      }
      //Make the background scroll again
      for(cloud c : clouds){
        c.start();
      }
    }
  }
  //Debug/Cheat keys
  else if(key == 'p'){//Reset hiscore
    hiscore = 0;
  }
  else if(key == 'o'){//toggle obstacle spawning
    spawnCalculator.toggleSpawning();
  }
}