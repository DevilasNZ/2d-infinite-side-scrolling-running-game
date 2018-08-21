//Class for generating a randomised rocky backdrop for the game.
//This class will be similar to the cloud class, except it will move with the player.
//Remember to draw another tone of blue to back the rocks for improved visuals.
class rock{
  private float x;
  private float y;
  private float w;
  private float h;
  
  private float rgb;
  
  public rock(){
    w = random(50,200);
    h = random(50,100);
    
    x = random(width+100);
    //y = height - random(100+h,200);
    y = height - (120+h);
    
    rgb = random(60,120);
  }
  
  private void move(){
    x-=spawnCalculator.speed;
    
    //respawn if needed
    if(x+w < -100){
      x = width + random(250);
      
      w = random(50,200);
      h = random(50,100);
      y = height - (120+h);
      
      rgb = random(60,120);
    }
  }
  
  public void draw(){
    fill(rgb,rgb,rgb);
    noStroke();
    rect(x,y,w,h);
    this.move();
  }
}