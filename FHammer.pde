class FHammer extends FGameObject {
  int direction = L;
  int speed = 50;
  int frame = 0;

  int throwcooldown = 0;

  FHammer(float x, float y) {
    super(gridSize-15, gridSize);
    setPosition(x, y);
    setName("Hammerbro");
    setRotatable(false);
    attachImage(hammerb[0]);
  }
  void act() {
    if (isTouching("fireball")) {
      world.remove(this);
      enemies.remove(this);
    }
    animate();
    collide();
    move();
    hammers();
  }
  void animate() {
    if (frame >= hammerb.length) frame = 0;
    if (frameCount %5 == 0) {
      if (direction == R) attachImage(hammerb[frame]);
      if (direction == L) attachImage(reversingImage(hammerb[frame]));
      frame++;
    }
  }
  void collide() {
    if (isTouching("wall")) {
      direction *= -1;
      setPosition(getX()+direction, getY());
    }
    if (isTouching("player")) {
      if (player.getY() < getY()-gridSize/2) {
        world.remove(this);
        enemies.remove(this);
        player.setVelocity(player.getVelocityX(), -300);
      } else {
        player.lives--;
        player.setVelocity(0, 0);
        player.setPosition(respawnX, respawnY);
        kills.rewind();
        kills.play();
        player.canmove = false;
        player.timer = 100;
      }
    }
  }
  void move() {
    float vy = getVelocityY();
    setVelocity(speed*direction, vy);
  }
  void hammers() {
    if (isSensor()) return;

    if (throwcooldown > 0) {
      throwcooldown--;
      return;
    }

    throwcooldown = 150;

    FGameObject hammer = new FGameObject(20, 20);
    hammer.setPosition(getX(), getY() - gridSize/2);
    hammer.setVelocity(200 * direction, -500);
    hammer.setAngularVelocity(30 * direction);
    hammer.setSensor(true);
    hammer.setRestitution(0.4);
    hammer.attachImage(hammerbro);
    hammer.setName("hammer");

    world.add(hammer);
  }
}
