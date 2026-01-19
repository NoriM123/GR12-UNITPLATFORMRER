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
