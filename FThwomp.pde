class FThwomp extends FGameObject {
  boolean Sense = false;
  FBox thwompSensor;

  float startY;
  boolean falling = false;
  boolean rising = false;

  FThwomp(float x, float y) {
    super(gridSize*2, gridSize*2);
    setPosition(x, y);
    setRestitution(0);
    setRotatable(false);
    setStatic(true);
    setDensity(10000);
    setName("thwomp");
    attachImage(thwomp[0]);
    startY = y;

    thwompSensor = new FBox(gridSize*2, 32*7);
    thwompSensor.setStaticBody(true);
    thwompSensor.setSensor(true);
    thwompSensor.setNoStroke();
    thwompSensor.setFill(255, 0);
    thwompSensor.setName("thwompSensor");
    world.add(thwompSensor);
  }

  void act() {
    thwompSensor.setPosition(getX(), getY() + 96);

    if (issTouching(thwompSensor, "player")) {
      Sense = true;
    }

    moveThwomp();
    animate();
  }

  void animate() {
    if (Sense) attachImage(thwomp[1]);
    else attachImage(thwomp[0]);
  }

  void moveThwomp() {
    if (Sense && !falling && !rising) {
      falling = true;
      setStatic(false);
      setVelocity(0, 100);
    }

    if (falling && isTouching("floor") || isTouching("player")) {
      setVelocity(0, 0);
      falling = false;
      rising = true;
    }
    if (isTouching("player")) {
      player.setPosition(96, 220);
      player.setVelocity(0, 0);
      player.canmove = false;
      player.timer = 100;
      touched = true;
    }

    if (rising) {
      setVelocity(0, -100);
      if (getY() <= startY) {
        setPosition(getX(), startY);
        setVelocity(0, 0);
        setStatic(true);
        rising = false;
        Sense = false;
      }
    }
  }
}
