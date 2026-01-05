import fisica.*;
FWorld world;

color black = #000000;
color green = #00FF00;
color red   = #FF0000;
color blue  = #0000FF;
color orange= #F0A000;
color cyan = color(153, 217, 234);
color brown = color(185, 122, 87);
color pink = color(255, 174, 201);

PImage map, ice, stone, treeTrunk, spring, treetopm, treetopl, treetopr, bridgec, bridgeintersection;
PImage spike;
PImage background;

PImage[] idle;
PImage[] jump;
PImage[] run;
PImage[] action;
PImage[] goomba;

ArrayList<FGameObject> terrain;
ArrayList<FGameObject> enemies;

int gridSize = 32;
float zoom = 1.5;
boolean upkey, downkey, leftkey, rightkey, wkey, akey, skey, spacekey, dkey;

FPlayer player;

void setup() {
  size(700, 393, P2D);
  Fisica.init(this);
  loadImages();

  loadWorld(map);
  loadPlayer();
}

void loadImages() {
  background = loadImage("super.jpg");
  map = loadImage("Untitled.png");
  ice = loadImage("blueBlock.png");
  treeTrunk = loadImage("tree_trunk.png");
  ice.resize(32, 32);
  stone = loadImage("brick.png");
  treetopm = loadImage("treetop_center.png");
  treetopl = loadImage("treetop_w.png");
  treetopr = loadImage("treetop_e.png");
  bridgec = loadImage("bridge_center.png");
  spike = loadImage("spikes.png");
  bridgeintersection = loadImage("tree_intersect.png");

  idle = new PImage[2];
  idle[0] = loadImage("idle0.png");
  idle[1] = loadImage("idle1.png");

  jump = new PImage[1];
  jump[0] = loadImage("jump0.png");

  run = new PImage[3];
  run[0] = loadImage("runright0.png");
  run[1] = loadImage("runright1.png");
  run[2] = loadImage("runright2.png");
  action = idle;

  goomba = new PImage[2];
  goomba[0] = loadImage("goomba0.png");
  goomba[0].resize(gridSize, gridSize);
  goomba[1] = loadImage("goomba1.png");
  goomba[1].resize(gridSize, gridSize);
}

void loadWorld(PImage img) {
  world = new FWorld(-2000, -2000, 2000, 2000);
  world.setGravity(0, 900);

  for (int y = 0; y < map.height; y++) {
    for (int x = 0; x < map.width; x++) {
      color c = img.get(x, y);
      FBox b = new FBox(gridSize, gridSize);
      b.setPosition(x*gridSize, y*gridSize);
      b.setStatic(true);
      if (c == black) {
        b.attachImage(stone);                          //color black = #000000;
        //color green = #00FF00;
        //color red   = #FF0000;
        //color blue  = #0000FF;
        //color orange= #F0A000;
        //color cyan = color(153, 217, 234);
        //color brown = color(185, 122, 87);
        b.setFriction(6);
        b.setName("stonebricks");
        world.add(b);
      }
      if (c == cyan) {
        b.attachImage(ice);
        b.setFriction(0);
        b.setName("ice");
        world.add(b);
      }
      if (c == brown) {
        b.attachImage(treeTrunk);
        b.setSensor(true);
        b.setName("tree trunk");
        world.add(b);
      }
      if (c == #00FF00) {//green//
        b.attachImage(treetopm);
        b.setName("treetopw");
        b.setFriction(4);
        world.add(b);
      }
      if (c == #095D02) {
        b.attachImage(treetopl);
        b.setFriction(4);
        b.setName("treetopL");
        world.add(b);
      }
      if (c == #2FA025) {
        b.attachImage(treetopr);
        b.setFriction(4);
        b.setName("treetopr");
        world.add(b);
      }
      if (c == #5D2400) {
        b.attachImage(bridgec);
        b.setFriction(6);
        b.setName("bridgew");
        world.add(b);
      }
      if (c == #A2A2A2) {
        b.attachImage(spike);
        b.setName("spikes");
        world.add(b);
      }
      if (c == pink) {
        b.attachImage(bridgeintersection);
        b.setName("intersec");
        world.add(b);
      }
    }
  }
}

void loadPlayer() {
  player = new FPlayer();
  world.add(player);
}

void draw() {
  background(background);
  drawWorld();
  player.act();
}

void actWorld() {
  player.act();
  for (int i = 0; i < terrain.size(); i++) {
    FGameObject t = terrain.get(i);
    t.act();
  }
}

void drawWorld() {
  pushMatrix();
  translate(-player.getX()+width/2, -player.getY()+height/2);
  world.step();
  world.draw();
  popMatrix();
}
