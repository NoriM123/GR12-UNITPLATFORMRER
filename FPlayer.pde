class FPlayer extends FGameObject {

  FBox footSensor;
  FBox headSensor;
  FBox liquids;
  FBox attack;
  int lavaCooldown = 0;
  int frame;
  int direction;
  int portalCooldown = 0;
  int lives;
  int timer = 0;
  boolean canmove = true;
  boolean touchground;
  boolean inLiquid = false;
  int jumps = 0;
  int timer2 = 0;

  FPlayer() {
    super(gridSize, gridSize);
    frame = 0;
    lives = 3;
    setPosition(96, 220);
    setName("player");
    setRotatable(false);
    attachImage(idle[0]);

    footSensor = new FBox(gridSize - 10, 10);
    footSensor.setStaticBody(false);
    footSensor.setSensor(true);
    footSensor.setName("footSensor");
    footSensor.setNoStroke();
    footSensor.setFill(255, 0);
    world.add(footSensor);

    headSensor = new FBox(gridSize - 10, 10);
    headSensor.setStaticBody(false);
    headSensor.setSensor(true);
    headSensor.setName("headSensor");
    headSensor.setNoStroke();
    headSensor.setFill(255, 0);
    world.add(headSensor);

    liquids = new FBox(gridSize -10, 10);
    liquids.setStaticBody(false);
    liquids.setSensor(true);
    liquids.setName("liquids");
    liquids.setNoStroke();
    liquids.setFill(255, 0);
    world.add(liquids);

    attack = new FBox (gridSize -5, gridSize);
    attack.setStaticBody(false);
    attack.setSensor(true);
    attack.setName("attack");
    attack.attachImage(bat);
    attack.setStatic(true);
  }

  void act() {
    if (starpower && spacekey && starcd == 0) {
      shootfireball();
      starcd = 15;
    }
    if (touched) {
      lives--;
      touched = false;
    }
    if (portalCooldown > 0) portalCooldown--;
    if (lavaCooldown > 0) lavaCooldown--;
    input();
    animate();
    footSensor.setPosition(player.getX(), player.getY()+13);
    footSensor.setVelocity(player.getVelocityX(), player.getVelocityY());

    headSensor.setPosition(player.getX(), player.getY()-14);
    headSensor.setVelocity(player.getVelocityX(), player.getVelocityY());

    liquids.setPosition(player.getX(), player.getY());
    liquids.setVelocity(player.getVelocityX(), player.getVelocityY());

    collisions();


    if (issTouching(footSensor, "luckybox") ||issTouching(footSensor, "FPortalO") ||issTouching(footSensor, "FPortals")||issTouching(footSensor, "stonebricks") || issTouching(footSensor, "ice")|| issTouching(footSensor, "wall") || issTouching(footSensor, "treetopw") || issTouching(footSensor, "treetopL") || issTouching(footSensor, "treetopr") || issTouching(footSensor, "bridge") || issTouching(footSensor, "intersec") || issTouching(footSensor, "springss") || issTouching(footSensor, "topg") || issTouching(footSensor, "grasstl") || issTouching(footSensor, "grasstr") ||issTouching(footSensor, "wall")) {
      touchground = true;
    }

    inLiquid = issTouching(liquids, "lava");
    if (inLiquid) {
      println("in");
    }

    if (jumps == 3) {
      jumps = 0;
    }

    if (lives <= 0) {
      mode = 4;
      lives = 3;
    }

    if (timer2 == 1) {
      setPosition(96, 220);
    }
    if (timer2 > 0) {
      timer--;
      canmove = false;
    } else if (timer <=0) {
      canmove = true;
    }

    if (timer > 0) {
      timer--;
      canmove = false;
    } else if (timer <= 0) {
      canmove = true;
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

  void input() {
    float vy = getVelocityY();
    float vx = getVelocityX();
    if (abs(vy) < 0.1) {
      action = idle;
    }
    if (akey && canmove) {
      setVelocity(-200, vy);
      action = run;
      direction = L;
    }
    if (dkey && canmove) {
      setVelocity(200, vy);
      action = run;
      direction = R;
    }
    if (wkey && canmove && (touchground || jumps == 1)) {
      setVelocity(vx, -400);
      jumps = jumps + 1;
      touchground = false;
    }
    if (abs(vy) > 0.1 && canmove)
      action = jump;
  }


  void collisions() {
    if (issTouching(footSensor, "spikes")) {
      lives--;
      setVelocity(0, 0);
      setPosition(96, 220);
      player.canmove = false;
      player.timer = 100;
    }

    if (issTouching(footSensor, "FPortals") && player.portalCooldown == 0) {
      player.setPosition(portalOut.getX(), portalOut.getY() - 100);
      player.setVelocity(0, 0);
      player.canmove = false;
      player.timer = 100;
      player.portalCooldown = 300;
    }

    if (issTouching(footSensor, "FPortalO") && player.portalCooldown == 0) {
      player.setPosition(portalIn.getX(), portalIn.getY() - 100);
      player.setVelocity(0, 0);
      player.canmove = false;
      player.timer = 100;
      player.portalCooldown = 300;
    }
    if (issTouching(liquids, "lava") && lavaCooldown == 0) {
      lives--;
      setVelocity(0, 0);
      canmove = false;
      timer2 = 200;
      lavaCooldown = 200;
    }
    if (isTouching("drop")) {
      hasStar = true;
      drops = true;
      starpower = true;
      starpowertimer = 500;
      if (drop != null) {
        world.remove(drop);
        drop = null;
      }
    }
    if (isTouching("koopadrop")) {
      hasShell = true;
      koopadrops = true;
    }
  }
}
