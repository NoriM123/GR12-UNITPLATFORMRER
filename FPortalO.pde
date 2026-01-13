class FPortalO extends FGameObject {

  FPortalO(float x, float y) {
    super();
    setPosition(x, y);
    setName("FPortalO");
    setStatic(true);
  }

  void act() {
    if (isTouching("player") && player.portalCooldown == 0) {
      player.setPosition(portalIn.getX(), portalIn.getY() - 100);
      player.setVelocity(0, 0);
      player.canmove = false; 
      player.timer = 100;
      player.portalCooldown = 300;
    }
  }
}
