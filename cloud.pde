class cloud{
  private float x;
  private float y;
  private float w;
  private float h;
  
  private float speed = 2;
  private final float defaultSpeed = speed;
  
  public cloud(){
    x = random(width+100);
    y = random(200);
    
    w = random(150,600);
    h = random(50,100);
  }
  
  private void move(){
    x-=speed;
    
    //respawn if needed
    if(x+w < -100){
      x = width + random(250);
      
      w = random(150,600);
      h = random(50,100);
    }
  }
  
  public void stop(){speed = 0;}
  public void start(){speed = defaultSpeed;}
  
  public void draw(){
    fill(255,255,255,230);
    noStroke();
    rect(x,y,w,h);
    this.move();
  }
}