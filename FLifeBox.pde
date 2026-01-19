class FLifeBox extends FGameObject {

  boolean activated = false;
  boolean bouncing = false;
  float baseY;
  int bounceTimer = 0;

  FLifeBox(float x, float y) {
    super(gridSize, gridSize);
    setPosition(x, y);
    setName("LifeBox");
    setStatic(true);
    attachImage(lifebox[0]);
    baseY = y;
  }

  void act() {
    if (!activated && issTouching(player.headSensor, "LifeBox")) {
      activated = true;
      onHit();
    }
    if (bouncing) {
      if (bounceTimer > 5) {
        setPosition(getX(), baseY - 6);
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
    attachImage(lifebox[1]);
    heartDrop(getX(), getY() - gridSize/2 - 12);
    bouncing = true;
    bounceTimer = 12;
  }
}
