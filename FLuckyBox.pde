class FLuckyBox extends FGameObject {

  boolean activated = false;
  boolean bouncing = false;
  float baseY;
  int bounceTimer = 0;

  FLuckyBox(float x, float y) {
    super(gridSize, gridSize);
    setPosition(x, y);
    setName("luckybox");
    setStatic(true);
    attachImage(luckybox[0]);
    baseY = y;
  }

  void act() {
    if (!activated && issTouching(player.headSensor, "luckybox")) {
      activated = true;
      onHit();
    }
    if (bouncing) {
      if (bounceTimer > 5) {
        setPosition(getX(), baseY - 6);   // move up
      } else {
        setPosition(getX(), baseY);
      }

      bounceTimer--;

      if (bounceTimer <= 0) {
        bouncing = false;
        setPosition(getX(), baseY);
      }
    }
  }

  void onHit() {
    attachImage(luckybox[1]);
    sDrop(getX(), getY() - gridSize/2 - 12);
    bouncing = true;
    bounceTimer = 12;
  }
}
