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
  if (lives == 4) {
    image(heart1, 36+33+33, height-35);
    image(heart, 36+33, height - 35);
    image(heart, 37, height - 35);
    image(heart, 6, height - 35);
  }
  if (lives == 3) {
    image(heart, 36+33, height - 35);
    image(heart, 37, height - 35);
    image(heart, 6, height - 35);
  }

  if (lives == 2) {
    image(heart, 37, height - 35);
    image(heart, 6, height - 35);
  }

  if (lives == 1) {
    image(heart, 6, height - 35);
  }
}

PImage reversingImage(PImage image) {
  PImage reverse;
  reverse = createImage(image.width, image.height, ARGB);

  for (int i=0; i < image.width; i++) {
    for (int j=0; j < image.height; j++) {
      int xPixel, yPixel;
      xPixel = image.width - 1 - i;
      yPixel = j;
      reverse.pixels[yPixel*image.width+xPixel] = image.pixels[j*image.width+i];
    }
  }
  return reverse;
}
