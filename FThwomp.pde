class FThwomp extends FGameObject {

  int mode = 0;
  float sensor = gridSize;
  float startY;
  float riseSpeed = -1.5;

  FBox thwompSensor;

  FThwomp(float x, float y) {
    super(gridSize*2, gridSize*2);
    startY = y;
    setPosition(x, y);
    setName("thwomp");
    setRotatable(false);
    setStatic(true);
    attachImage(thwomp[0]);

    thwompSensor = new FBox(gridSize*2, 225);
    thwompSensor.setStaticBody(true);
    thwompSensor.setSensor(true);
    thwompSensor.setFill(255, 0);
    thwompSensor.setNoStroke();
    thwompSensor.setName("thwompSensor");
    world.add(thwompSensor);
  }

  void act() {

    thwompSensor.setPosition(getX(), getY() + 112);
    if (mode == 1) attachImage(thwomp[1]);
    else attachImage(thwomp[0]);
    checkPlayer();
    fall();
    rise();
    hitPlayer();
  }


  void checkPlayer() {
    if (mode != 0) return;

    boolean under = false;

    if (issTouching(thwompSensor, "player")) {
      under = true;
    }

    if (under) {
      thwomps.rewind();
      thwomps.play();
      mode = 1;
      setStatic(false);
    }
  }

  void fall() {
    if (mode != 1) return;

    if (isTouching("stonebricks")) {
      mode = 2;
      setStatic(true);
    }
  }

  void rise() {
    if (mode != 2) return;

    float newY = getY() + riseSpeed;

    if (newY <= startY) {
      newY = startY;
      mode = 0;
    }

    setPosition(getX(), newY);
  }


  void hitPlayer() {
    if (isTouching("player")) {
      player.lives--;
      player.setPosition(respawnX, respawnY);
      kills.rewind();
      kills.play();
    }
  }
}
