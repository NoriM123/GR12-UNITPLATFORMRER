void game() {
  background(background);
  drawWorld();
  actWorld();
  player.act();
  pausebutton();
}

void gameClicks() {
  if (dist(20, 20, mouseX, mouseY) < 10) {
    mode = PAUSE;
  }
}

void pausebutton() {
  fill(255);
  noStroke();
  rect(17, 20, 3, 10, 5);
  rect(23, 20, 3, 10, 5);
}
