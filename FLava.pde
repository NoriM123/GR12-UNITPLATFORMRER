class FLava extends FGameObject {

  int frame = 0;
  int speed = 50;

  FLava(float x, float y) {
    super(gridSize, gridSize);
    setPosition(x, y);
    setName("lava");
    setStatic(true);
    setSensor(true);
    attachImage(lava[0]);
  }

  void act() {
    if (frameCount % speed == 0) {
      frame++;
      if (frame == lava.length) frame = 0;
      attachImage(lava[frame]);
    }
  }
}
