class FPortalO extends FGameObject {

  FPortalO(float x, float y) {
    super(gridSize, gridSize);
    setPosition(x, y);
    setName("FPortalO");
    setStatic(true);
  }

  void act() {
  }
}
