void pause() {
  pausecontinuebutton();
  pausepanel();
  themes.pause();

  drawLives(player.lives);
}

void pauseClicks() {
  if (mouseX>width/2 && mouseX<width/2+200 && mouseY>height/2-50 && mouseY<height/2+50) {
    themes.rewind();
    themes.play();
    mode = 1;
  }
  if (mouseX>width/2-200 && mouseX<width/2 && mouseY>height/2-50 && mouseY<height/2+50) {
    setup();
    drops = false;
    drop = null;
    koopadrops = false;
    kdrop = null;
    hasShell = false;
    hasStar = false;
    hdrop = null;
    heartdrops = false;
    respawnX = 496;
    respawnY = 100;

    mode = 0;
  }
}

void pausecontinuebutton() {
  fill(255);
  noStroke();
  circle(20, 20, 19);
  fill(255);
  stroke(0);
  triangle(16, 15, 16, 25, 26, 20);
}

void pausepanel() {
  fill(intro);
  noStroke();
  rect(width/2-5, height/2+5, 400, 100);
  rect(width/2+5, height/2+5, 400, 100);

  fill(backintro);
  noStroke();
  rect(width/2, height/2, 400, 100);

  fill(intro);
  textSize(42);
  text("Intro", width/2-100, height/2+13);
  text("Game", width/2 +100, height/2+13);

  fill(255);
  textSize(40);
  text("Intro", width/2 -100, height/2+13);
  text("Game", width/2 + 100, height/2+13);
}
