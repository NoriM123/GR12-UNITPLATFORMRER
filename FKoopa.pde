class FKoopa extends FGameObject {

  int dir = L;

  float walkSpd = 50;
  float shellSpd = 300;

  int mode;
  final int walking = 0;
  final int shellstop = 1;
  final int shellgo = 2;
  int frame = 0;

  int hitCD = 0;

  FKoopa(float x, float y) {
    super(gridSize, gridSize);
    setPosition(x, y);
    setName("koopa");
    setRotatable(false);
    setFriction(0);
    setRestitution(0);

    mode = walking;
  }

  void act() {
    if (hitCD > 0) hitCD--;

    if (isTouching("fireball")) {
      if (mode == walking) {
        mode = shellstop;               
        setVelocity(0, getVelocityY());   
        hitCD = 10;                        
      } else {

        world.remove(this);
        enemies.remove(this);
        return;
      }
    }

    hitWalls();
    hitPlayer();
    moveKoopa();
    drawKoopa();
  }

  void drawKoopa() {
    if (mode != walking) {
      attachImage(shell);
      return;
    }

    if (frame >= koopa.length) frame = 0;

    if (frameCount % 5 == 0) {
      if (dir == R) attachImage(koopa[frame]);
      if (dir == L) attachImage(reversingImage(koopa[frame]));
      frame++;
    }
  }

  void moveKoopa() {
    float vy = getVelocityY();

    if (mode == walking) {
      setVelocity(walkSpd * dir, vy);
    } else if (mode == shellgo) {
      setVelocity(shellSpd * dir, vy);  
    } else {
      setVelocity(0, vy); 
    }
  }

  void hitWalls() {
    if (!isTouching("wall")) return;

    if (mode == walking || mode == shellgo) {
      dir *= -1;
      setPosition(getX() + dir * 2, getY());
    }
  }

  void hitPlayer() {
    if (!isTouching("player")) return;

    if (hitCD > 0) return;

    boolean stomp = false;
    if (issTouching(player.footSensor, "koopa")){
     stomp = true; 
    }

    if (stomp) {
      hitCD = 10; 

      if (mode == walking) {
        mode = shellgo;                         
        dir = L;
        player.setVelocity(player.getVelocityX(), -300);
      }
      if (mode == shellgo) {
        mode = shellstop;
        player.setVelocity(player.getVelocityX(), -300);
      }
      if (mode == shellstop) {
        mode = shellgo;
        dir = L;
        player.setVelocity(player.getVelocityX(), -300);
      }
    }

    if (mode == walking || mode == shellgo) {
      hitCD = 20; 
      player.lives--;
      player.setPosition(respawnX, respawnY);
    }
  }
}
