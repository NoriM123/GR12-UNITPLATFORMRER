class FBridge extends FGameObject {
 
  FBridge(float x, float y) {
   super(gridSize, gridSize);
   setPosition(x, y);
   setName("bridgew");
   setStatic(true);
  }
  
  void act() {
   if(isTouching("player")) {
    setStatic(false);
    setSensor(true);
   }
  }
}
