void game() {
  background(background);
  drawWorld();
  actWorld();
  player.act();

  if (mode == 1) {
    pausebutton();
  }


  drawLives(player.lives);
}

void gameClicks() {
  if (dist(20, 20, mouseX, mouseY) < 10) {
    mode = PAUSE;
  }
}

void pausebutton() {

  fill(255);
  noStroke();
  circle(20, 20, 19);

  fill(255);
  stroke(0);
  rect(17, 20, 3, 10, 5);
  rect(23, 20, 3, 10, 5);
}
