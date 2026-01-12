class FPlayer extends FGameObject {

  FBox bottomSensor;

  int frame;
  int direction;
  int lives;

  boolean touchground;
  int jumps = 0;

  FPlayer() {
    super();
    frame = 0;
    lives = 3;
    setPosition(96, 220);
    setName("player");
    setRotatable(false);
    attachImage(idle[0]);
   // bottomssensor();
  }
  void act() {
    input();
    animate();
  //  bottomSensor.setPosition(getX(), getY() + getHeight()/2 + 2);
    collisions();

    if (isTouching("stonebricks") || isTouching("ice") || isTouching("treetopw") || isTouching("treetopL") || isTouching("treetopr") || isTouching("bridge") || isTouching("intersec") || isTouching("springss") || isTouching("topg") || isTouching("grasstl") || isTouching("grasstr") ||isTouching("wall")) {
      touchground = true;
    }

    if (jumps == 3) {
      jumps = 0;
    }

    if (lives <= 0) {
      mode = 4;
      lives = 3;
    }
  }

  void animate() {
    if (frame >= action.length) frame = 0;
    if (frameCount %5 == 0) {
      if (direction == R) attachImage(action[frame]);
      if (direction == L) attachImage(reversingImage(action[frame]));
      frame++;
    }
  }

  void bottomssensor() {
    bottomSensor = new FBox(gridSize - 11, 5);
    bottomSensor.setStaticBody(false);
    bottomSensor.setSensor(true);
    bottomSensor.setFill(255, 0);
    bottomSensor.setNoStroke();
    bottomSensor.setName("bottomSensor");
    world.add(bottomSensor);
  }


  void input() {
    float vy = getVelocityY();
    float vx = getVelocityX();
    if (abs(vy) < 0.1) {
      action = idle;
    }
    if (akey) {
      setVelocity(-200, vy);
      action = run;
      direction = L;
    }
    if (dkey) {
      setVelocity(200, vy);
      action = run;
      direction = R;
    }
    if (wkey && (touchground || jumps == 1)) {
      setVelocity(vx, -350);
      jumps = jumps + 1;
      touchground = false;
    }
    if (abs(vy) > 0.1)
      action = jump;
  }


  void collisions() {
    if (isTouching("spikes")) {
      lives--;
      setVelocity(0, 0);
      setPosition(96, 220);
    }
  }
}
