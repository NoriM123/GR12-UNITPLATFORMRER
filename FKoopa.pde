class FKoopa extends FGameObject {

  int direction = L;
  float walkSpeed  = 50;
  float shellSpeed = 300;

  int state;
  final int WALK = 0;
  final int SHELLSTILL = 1;
  final int SHELLMOVING = 2;

  int frame = 0;

  FKoopa(float x, float y) {
    super(gridSize, gridSize);
    setPosition(x, y);
    setName("koopa");
    setRotatable(false);
    setFriction(0);
    setRestitution(0);
    state = WALK;
  }


  void act() {
    if (isTouching("fireball")) {
      world.remove(this);
      enemies.remove(this);
    }
    animate();
    collide();
    move();
  }

  void animate() {
    if (state != WALK) {
      attachImage(shell);
      return;
    }

    if (frame >= koopa.length) frame = 0;
    if (frameCount % 5 == 0) {
      if (direction == R) attachImage(koopa[frame]);
      if (direction == L) attachImage(reversingImage(koopa[frame]));
      frame++;
    }
  }

  void move() {
    float vy = getVelocityY();

    if (state == WALK) {
      setVelocity(walkSpeed * direction, vy);
    } else if (state == SHELLMOVING) {
      setVelocity(shellSpeed * direction, vy);
    } else {
      setVelocity(0, vy);
    }
  }

  void collide() {
    if (isTouching("wall")) {
      if (state != SHELLSTILL) {
        direction *= -1;
        setPosition(getX() + direction * 2, getY());
      }
    }


    boolean stomp = false;
    
        if (!isTouching("player")) stomp = false;

    if (state == WALK && isTouching("fireball")) {
      state = SHELLSTILL;
    }

    if (issTouching(player.footSensor, "koopa") || isTouching("fireball")) {
      stomp = true;
    }


    if (stomp) {
      if (state == WALK) {
        state = SHELLSTILL;
        player.setVelocity(player.getVelocityX(), -300);
      }

      if (state == SHELLMOVING) {
        state = SHELLSTILL;
        player.setVelocity(player.getVelocityX(), -300);
      }

      if (state == SHELLSTILL) {
        world.remove(this);
        enemies.remove(this);
        player.setVelocity(player.getVelocityX(), -300);
      }
    }

    if (state == WALK) {
      player.lives--;
      player.setPosition(respawnX, respawnY);
    }

    if (state == SHELLSTILL) {
      state = SHELLMOVING;
      direction = (player.getX() < getX()) ? R : L;
    }
  }
}
