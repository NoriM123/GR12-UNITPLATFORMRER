class FBridge extends FGameObject {
 
  FBridge(float x, float y) {
   super();
   setPosition(x, y);
   setName("bridgew");
   setStatic(true);
   staticc = true;
  }
  
  void act() {
   if(isTouching("player")) {
    setStatic(false);
    staticc = false;
    setSensor(true);
   }
  }
}
