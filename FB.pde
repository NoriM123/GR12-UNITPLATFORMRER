class FBridge extends FGameObject {

  FBridge(float x, float y) {
    super(gridSize, gridSize);
    setPosition(x, y);
    setName("bridgew");
    setStatic(true);
  }

  void act() {
    if (isTouching("player")) {
      setStatic(false);
      setSensor(true);
      falling = true;
    }
    if (getY() > 2000) {       
      world.remove(this);
      terrain.remove(this);     
    }
  }
}

class FSpring extends FGameObject {

  FSpring(float x, float y) {
    super(gridSize, gridSize);
    setPosition(x, y);
    setStatic(true);
    setRestitution(1.6);
    setName("springss");
    attachImage(tramp3); 
  }

  void act() {
    if (isTouching("player")) {
      attachImage(spring);   
    } else {
      attachImage(tramp3); 
    }
  }
}
