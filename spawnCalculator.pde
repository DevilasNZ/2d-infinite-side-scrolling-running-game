static class spawnCalculator{
  ///////////////////////////////////////////////////////////
  //Manage the speed of objects moving on the ground
  public static final float speedIncrement = 0.001;
  public static float speed = 0;
  public static void speedCalculatorTick(){
    speed += speedIncrement;
  }
  public static void startObjects(){speed = 15;}
  public static void stopObjects(){speed = 0;}
  public static void restartObjects(){speed = 15;}
  
  ///////////////////////////////////////////////////////////
  //Manage the spawning of the Obstacles through a static set of variables and methods
  private static boolean spawningEnabled = true;
  private static float spawnChance = 0.05;  //A number between 0 and 1 which gives us the chance of allowing another obstacle to spawn
  private static float spawnChanceIncrement = 0.0005;
  private static Random rnd = new Random();
  private static float spawnRNG;
  
  public static boolean canSpawn(){  //  A method to determine whether or not an obstacle can spawn.
    spawnRNG = rnd.nextFloat();
    if(spawnRNG < spawnChance){
      return true;
    }
    spawnChance += spawnChanceIncrement;
    return false;
  }
  
  public static void justSpawned(){
    spawnChance = 0;
  }
  
  public static void toggleSpawning(){
    if(spawningEnabled){
      spawnChance = 0;
      spawnChanceIncrement = 0;
    }else{
      spawnChanceIncrement = 0.0005;
    }
  }
}