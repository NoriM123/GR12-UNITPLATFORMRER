class FGoomba extends FGameObject {
  int direction = L;
  int speed = 50;
  int frame = 0;

  FGoomba(float x, float y) {
    super(gridSize, gridSize);
    setPosition(x, y);
    setName("goomba");
    setRotatable(false);
    attachImage(goomba[0]);
  }
  void act() {
    if (isTouching("shell")) {
      world.remove(this);
      enemies.remove(this);
    }

    animate();
    collide();
    move();

    if (isTouching("fireball")) {
      world.remove(this);
      enemies.remove(this);
    }
  }
  void animate() {
    if (frame >= goomba.length) frame = 0;
    if (frameCount %5 == 0) {
      if (direction == R) attachImage(goomba[frame]);
      if (direction == L) attachImage(reversingImage(goomba[frame]));
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
}
