void game() {
  background(background);
  drawWorld();
  actWorld();
  player.act();
  checkDropRemove();
  checkKDropRemove();
  checkhDropRemove();
  images();



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

void images() {
  if (mode == 1) {
    pausebutton();
  }
  if (hasStar) {
    image(star, width - 50, 20, 32, 32);
    strokeWeight(2);

    float bar = map(starcd, 300, 0, 0, 100);
    stroke(0);
    fill(255);
    rect(width - 115, 37, 100, 20);
    fill(intro);
    rectMode(CORNER);
    rect(width - 165, 27, bar, 20);
    rectMode(CENTER);
  }
  if (hasShell) {
    image(shell, width - 100, 20, 32, 32);
  }
}
