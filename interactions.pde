void keyPressed() {
  if (key == 'S' || key == 's') skey = true;
  if (key == 'W' || key == 'w') wkey = true;
  if (key == 'A' || key == 'a') akey = true;
  if (key == 'D' || key == 'd') dkey = true;
  //if (key == 'Q' || key == 'q') qkey = true;
  //if (key == 'E' || key == 'e') ekey = true;
  if (key == ' ') spacekey = true;
  if (keyCode == DOWN)  downkey  = true;
  if (keyCode == UP)    upkey    = true;
  if (keyCode == LEFT)  leftkey  = true;
  if (keyCode == RIGHT) rightkey = true;

  if (keyCode == ESC) {
    key = 0;
    mode = 2;
  }
}

void keyReleased() {
  if (key == 'S' || key == 's') skey = false;
  if (key == 'W' || key == 'w') wkey = false;
  if (key == 'A' || key == 'a') akey = false;
  if (key == 'D' || key == 'd') dkey = false;
  //if (key == 'Q' || key == 'q') qkey = false;
  //if (key == 'E' || key == 'e') ekey = false;
  if (key == ' ') spacekey = false;
  if (keyCode == DOWN)  downkey  = false;
  if (keyCode == UP)    upkey    = false;
  if (keyCode == LEFT)  leftkey  = false;
  if (keyCode == RIGHT) rightkey = false;
}

void mouseReleased() {
  if (mode == INTRO) {
    introClicks();
  } else if (mode == GAME) {
    gameClicks();
  } else if (mode == PAUSE) {
    pauseClicks();
  } else if (mode == GAMEWIN) {
    gamewinClicks();
  } else if (mode == GAMEOVER) {
    gameoverClicks();
  }
}

void drawLives(int lives) {
  if (lives == 3) {
    fill(intro);
    textSize(32);
    text("000", width - 60, height - 25);

    fill(#e31b23);
    textSize(30);
    text("000", width - 60, height - 25);
  }

  if (lives == 2) {
    fill(intro);
    textSize(32);
    text("00", width - 67, height - 25);

    fill(#e31b23);
    textSize(30);
    text("00", width - 67, height - 25);
  }

  if (lives == 1) {
    fill(intro);
    textSize(32);
    text("0", width - 74, height - 25);

    fill(#e31b23);
    textSize(30);
    text("0", width - 74, height - 25);
  }
}
