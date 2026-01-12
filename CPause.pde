void pause() {
  background(background);
  pausecontinuebutton();
  pausepanel();
  drawLives(player.lives); 
}

void pauseClicks() {
  if (mouseX>width/2 && mouseX<width/2+200 && mouseY>height/2-50 && mouseY<height/2+50) {
    mode = 1;
  }
  if (mouseX>width/2-200 && mouseX<width/2 && mouseY>height/2-50 && mouseY<height/2+50) {
    setup();
    mode = 0;
  }
}

void pausecontinuebutton() {
  fill(255);
  stroke(0);
  triangle(15, 15, 15, 25, 25, 20);
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
