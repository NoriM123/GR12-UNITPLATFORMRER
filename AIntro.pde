void intro() {
  background(background);
  textAlign(CENTER);
  rectMode(CENTER);

  fill(intro);
  noStroke();
  rect(width/2-5, height/2+5, 400, 100);
  rect(width/2+5, height/2+5, 400, 100);


  fill(backintro);
  noStroke();
  rect(width/2, height/2, 400, 100);

  fill(intro);
  textSize(42);
  text("Super Mario", width/2, height/2);
  textSize(19);
  text("Click to start", width/2, height/2+35);

  fill(255);
  textSize(40);
  text("Super Mario", width/2, height/2);
  textSize(18);
  text("Click to start", width/2, height/2+35);
}

void introClicks() {
  if (mouseX> width/2 - 200 && mouseX<width/2+200 && mouseY>height/2 - 50 && mouseY<height/2 +50) {
    mode = 1;
  }
}
