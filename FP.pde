class FPortal extends FGameObject {
  FPortal(float x, float y) {
    super(gridSize * 2, gridSize * 2);
    setPosition(x + gridSize, y + gridSize);
    setName("FPortals");
    setStatic(true);
    setSensor(false);  
  }
  void act() {
  }
}

class FPortalO extends FGameObject {
  FPortalO(float x, float y) {
    super(gridSize * 2, gridSize * 2);
    setPosition(x + gridSize, y + gridSize);
    setName("FPortalO");
    setStatic(true);
    setSensor(false);  
  }
  void act() {
  }
}
