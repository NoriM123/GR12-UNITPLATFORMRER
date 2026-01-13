class FPortal extends FGameObject {

  FPortal(float x, float y) {
    super();
    setPosition(x, y);
    setName("FPortals");
    setStatic(true);
  }

  void act() {
    if (isTouching("player") && player.portalCooldown == 0) {
      player.setPosition(portalOut.getX(), portalOut.getY() - 100);
      player.setVelocity(0, 0);
      player.canmove = false;
      player.timer = 100;
      player.portalCooldown = 300;
    }
  }
}
