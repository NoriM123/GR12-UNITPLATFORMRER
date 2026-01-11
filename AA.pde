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
color grey = color (127, 127, 127);
color reds = color (136, 0, 21);
color yellowC = color(239, 228, 176);
color yellowL = color(255, 201, 14);
color yellowR = color(255, 242, 0);
color greenT = color(181, 230, 29);
color greenTL = color(34, 177, 76);
color blueTR = color(153, 217, 235);
color blueBR = color(112, 146, 190);
color blueBL = color(63, 72, 204);
color violetB = color(163, 73, 164);
color sixtyfour = color(64, 0, 64);
color browny = color(128, 64, 0);
color intro = #C69898;
color backintro = #C84C0C;

PFont myFont;

PImage map, ice, stone, treeTrunk, spring, treetopm, treetopl, treetopr, bridgec, bridgeintersection;
PImage spike, cloud, wall;
PImage background;
PImage gc, gr, gt, gtr, gtl, gb, gbr, gbl, gl;
boolean staticc;

int mode;
final int INTRO = 0;
final int GAME = 1;
final int PAUSE = 2;
final int GAMEWIN = 3;
final int GAMEOVER = 4;


PImage[] idle;
PImage[] jump;
PImage[] run;
PImage[] action;
PImage[] goomba;
PImage[] gif;

ArrayList<FGameObject> terrain;
ArrayList<FGameObject> enemies;

int gridSize = 32;
float zoom = 1.5;
boolean upkey, downkey, leftkey, rightkey, wkey, akey, skey, spacekey, dkey;

FPlayer player;

void setup() {
  size(700, 393, P2D);
  mode = 0;
  Fisica.init(this);
  terrain = new ArrayList<FGameObject> ();
  enemies = new ArrayList<FGameObject> ();
  loadImages();
  myFont = createFont("PLANK___.TTF", 100);
  textFont(myFont);
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
  //cloud = loadImage("spikess.png");
  treetopr = loadImage("treetop_e.png");
  bridgec = loadImage("bridge_center.png");
  spike = loadImage("spike.png");
  bridgeintersection = loadImage("tree_intersect.png");
  spring = loadImage("trampoline.png");
  wall = loadImage("wall.png");

  gc = loadImage("dirt_center.png");
  gr = loadImage("dirt_e.png");
  gt = loadImage("dirt_n.png");
  gtr = loadImage("dirt_ne.png");
  gtl = loadImage("dirt_nw.png");
  gb = loadImage("dirt_s.png");
  gbr = loadImage("dirt_se.png");
  gbl = loadImage("dirt_sw.png");
  gl = loadImage("dirt_w.png");

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
      } else if (c == cyan) {
        b.attachImage(ice);
        b.setFriction(0);
        b.setName("ice");
        world.add(b);
      } else if (c == brown) {
        b.attachImage(treeTrunk);
        b.setSensor(true);
        b.setName("tree trunk");
        world.add(b);
      } else if (c == #00FF00) {//green//
        b.attachImage(treetopm);
        b.setName("treetopw");
        b.setFriction(4);
        world.add(b);
      } else if (c == #095D02) {
        b.attachImage(treetopl);
        b.setFriction(4);
        b.setName("treetopL");
        world.add(b);
      } else if (c == #2FA025) {
        b.attachImage(treetopr);
        b.setFriction(4);
        b.setName("treetopr");
        world.add(b);
      } else if (c == #5D2400) {
        FBridge br = new FBridge(x*gridSize, y*gridSize);
        terrain.add(br);
        br.attachImage(bridgec);
        world.add(br);
      } else if (c == #A2A2A2) {
        b.attachImage(spike);
        b.setName("spikes");
        world.add(b);
      } else if (c == pink) {
        b.attachImage(bridgeintersection);
        b.setName("intersec");
        world.add(b);
      } else if (c == reds) {
        b.attachImage(spring);
        b.setName("springss");
        b.setRestitution(2);
        world.add(b);
      } else if (c == yellowC) {
        b.attachImage(gc);
        b.setName("Centerc");
        b.setFriction(6);
        world.add(b);
      } else if (c == yellowL) {
        b.attachImage(gl);
        b.setName("leftg");
        b.setFriction(6);
        world.add(b);
      } else if (c == yellowR) {
        b.attachImage(gr);
        b.setName("rightg");
        b.setFriction(6);
        world.add(b);
      } else if (c == greenT) {
        b.attachImage(gt);
        b.setName("topg");
        b.setFriction(6);
        world.add(b);
      } else if (c == greenTL) {
        b.attachImage(gtl);
        b.setName("grasstl");
        b.setFriction(6);
        world.add(b);
      } else if (c == blueTR) {
        b.attachImage(gtr);
        b.setName("grasstr");
        b.setFriction(6);
        world.add(b);
      } else if (c == blueBR) {
        b.attachImage(gbr);
        b.setName("grassbr");
        b.setFriction(6);
        world.add(b);
      } else if (c == blueBL) {
        b.attachImage(gbl);
        b.setName("grassbl");
        b.setFriction(6);
        world.add(b);
      } else if (c == violetB) {
        b.attachImage(gb);
        b.setName("grassb");
        b.setFriction(6);
        world.add(b);
      } else if (c== sixtyfour) {
        b.attachImage(wall);
        b.setName("wall");
        world.add(b);
        b.setFriction(3);
      } else if (c == browny) {
        FGoomba gmb = new FGoomba(x*gridSize, y*gridSize);
        enemies.add(gmb);
        world.add(gmb);
      }
    }
  }
}

void loadPlayer() {
  player = new FPlayer();
  world.add(player);
}
void draw() {
  if (mode == INTRO) {
    intro();
  } else if (mode == GAME) {
    game();
  } else if (mode == PAUSE) {
    pause();
  } else if (mode == GAMEWIN) {
    gamewin();
  } else if (mode == GAMEOVER) {
    gameover();
  } else {
    println("Mode Error" + mode);
  }
}


void actWorld() {
  player.act();
  for (int i = 0; i < terrain.size(); i++) {
    FGameObject t = terrain.get(i);
    t.act();
  }
  for (int i = 0; i<enemies.size(); i++) {
    FGameObject e = enemies.get(i);
    e.act();
  }
}
void drawWorld() {
  pushMatrix();
  translate(-player.getX()+width/2, -player.getY()+height/2);
  world.step();
  world.draw();
  popMatrix();
}
