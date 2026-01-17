class FKoopa extends FGameObject {
  int direction = L;
  int speed = 50;
  int frame = 0;
  boolean activated = false;
  FCircle kd;

  FKoopa(float x, float y) {
    super(gridSize, gridSize);
    setPosition(x, y);
    setName("koopa");
    setRotatable(false);
    attachImage(koopa[0]);
  }
  void act() {
    animate();
    collide();
    move();
  }
  void animate() {
    if (frame >= koopa.length) frame = 0;
    if (frameCount %5 == 0) {
      if (direction == R) attachImage(koopa[frame]);
      if (direction == L) attachImage(reversingImage(koopa[frame]));
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
        activated = true;
        KoopaDrop(getX(), getY() - gridSize/2 - 12);
        world.remove(this);
        enemies.remove(this);
        player.setVelocity(player.getVelocityX(), -300);
      } else {
        player.lives--;
        player.setVelocity(0, 0);
        player.setPosition(96, 220);
        player.canmove = false;
        player.timer = 100;
      }
    }
  }
  void move() {
    float vy = getVelocityY();
    setVelocity(speed*direction, vy);
  }
}
