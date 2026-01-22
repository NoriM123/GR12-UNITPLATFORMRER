void gameover() {

  gameoverart();
}

void gameoverClicks() {
  if (mouseX> width/2 - 200 && mouseX<width/2+200 && mouseY>height/2 - 50 && mouseY<height/2 +50) {
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

void gameoverart() {
  // background(background);
  image(mmmyGif, 0, 0, width, height);
  fill(intro);
  noStroke();
  rect(width/2-5, height/2+5, 400, 100);
  rect(width/2+5, height/2+5, 400, 100);

  fill(backintro);
  noStroke();
  rect(width/2, height/2, 400, 100);

  fill(intro);
  textSize(40);
  text("Play Again", width/2, height/2+16);
  fill(255);
  textSize(42);
  text("Play Again", width/2, height/2+13);
}
