import fisica.*;
import gifAnimation.*;
import ddf.minim.*;
Minim minim;
FWorld world;
FPortal portalIn;
FPortalO portalOut;
FCircle drop, kdrop, hdrop;
Gif myGif, mmyGif, mmmyGif;

float respawnX = 496;
float respawnY = 100;

ArrayList<FGameObject> terrain;
ArrayList<FGameObject> enemies;
ArrayList<FCircle> fireballs;

boolean drops, heartdrops, koopadrops, touched, falling, hasStar, hasShell, starpower = false;
boolean upkey, downkey, leftkey, rightkey, wkey, akey, skey, spacekey, dkey, escape;

PFont myFont;

int numberOfFrames, nnumberofframes, f, v, r;
int gridSize = 32;
int times100 = 0;
int starpowertimer, starcd = 0;
float zoom = 1.5;

PImage finish, lilguy, hammerbro, chute1, chute2, heart1, tramp3, one, two, three, four, bat, fireball, heart, star, background, gc, gr, gt, gtr, gtl, gb, gbr, gbl, gl, map, ice, stone, treeTrunk, spring, treetopm, treetopl, treetopr, bridgec, bridgeintersection, spike, cloud, wall, teleport, teleports, starbackground, shell;

PImage[] idle, jump, run, action, goomba, gif, lava, water, thwomp, luckybox, koopa, lifebox, hammerb;

FPlayer player;

AudioPlayer kills, jumpss, wins, gameovers, falls, thwomps, themes, checkmark;

void setup() {
  minim = new Minim(this);
  jumpss = minim.loadFile("jump.wav");
  wins = minim.loadFile("win.wav");
  kills = minim.loadFile("kill.wav");
  gameovers = minim.loadFile("gameover.wav");
  thwomps = minim.loadFile("thwomp.mp3");
  themes = minim.loadFile("theme.mp3");
  checkmark = minim.loadFile("checkmark.mp3");

  themes.rewind();
  themes.play();
  themes.loop();
  size(1300, 800, P2D);
  mode = 0;
  Fisica.init(this);
  terrain = new ArrayList<FGameObject> ();
  enemies = new ArrayList<FGameObject> ();
  fireballs  = new ArrayList<FCircle>();
  loadImages();
  myFont = createFont("PLANK___.TTF", 100);
  textFont(myFont);
  loadWorld(map);
  loadPlayer();
  myGif = new Gif(this, "1gif.gif");
  myGif.loop();
  mmyGif = new Gif(this, "2gif.gif");
  mmyGif.loop();
  mmmyGif = new Gif(this, "3gif.gif");
  mmmyGif.loop();
}

void loadImages() {
  finish = loadImage("gold.png");
  background = loadImage("superfinal.png");
  heart = loadImage("hart.png");
  heart.resize(32, 32);
  bat = loadImage("bat2.png");
  bat.resize(50, 50);
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
  spike.resize(32, 30);
  bridgeintersection = loadImage("tree_intersect.png");
  spring = loadImage("trampoline.png");
  wall = loadImage("wall.png");
  fireball = loadImage("fireball.png");
  fireball.resize(32, 32);
  tramp3 = loadImage("trampoline3.png");
  heart1 = loadImage("hart1.png");
  heart1.resize(32, 32);
  chute1 = loadImage("Chute1.png");
  chute2 = loadImage("Chute1 copy.png");
  chute1.resize(gridSize * 2, gridSize * 2);
  chute2.resize(gridSize * 2, gridSize * 2);
  hammerbro = loadImage("hammer.png");

  gc = loadImage("dirt_center.png");
  gr = loadImage("dirt_e.png");
  gt = loadImage("dirt_n.png");
  gtr = loadImage("dirt_ne.png");
  gtl = loadImage("dirt_nw.png");
  gb = loadImage("dirt_s.png");
  gbr = loadImage("dirt_se.png");
  gbl = loadImage("dirt_sw.png");
  gl = loadImage("dirt_w.png");
  star = loadImage("bigbigstar.png");
  shell = loadImage("shell.png");
  one = loadImage("one.png");
  two = loadImage("two.png");
  three = loadImage("three.png");
  four = loadImage("four.png");
  lilguy = loadImage("littelboy.png");
  teleport = loadImage("gold.png");
  teleports = loadImage("gold copy.png");

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

  lava = new PImage[6];
  lava[0] = loadImage("lava0.png");
  lava[1] = loadImage("lava1.png");
  lava[2] = loadImage("lava2.png");
  lava[3] = loadImage("lava3.png");
  lava[4] = loadImage("lava4.png");
  lava[5] = loadImage("lava5.png");
  lava[5].resize(gridSize, gridSize);

  water = new PImage[4];
  water[0] = loadImage("water0.png");
  water[1] = loadImage("water1.png");
  water[2] = loadImage("water2.png");
  water[3] = loadImage("water3.png");

  thwomp = new PImage[2];
  thwomp[0] = loadImage("thwomp0.png");
  thwomp[0].resize(gridSize*2, gridSize*2);
  thwomp[1] = loadImage("thwomp1.png");
  thwomp[1].resize(gridSize*2, gridSize*2);

  luckybox = new PImage[2];
  luckybox[0] = loadImage("luckybox0.png");
  luckybox[1] = loadImage("luckybox1.png");

  lifebox = new PImage[2];
  lifebox[0] = loadImage("lifebox0.png");
  lifebox[1] = loadImage("lifebox1.png");

  koopa = new PImage[2];
  koopa[0] = loadImage("koopa0.png");
  koopa[1] = loadImage("koopa1.png");

  hammerb = new PImage[2];
  hammerb[0] = loadImage("hammerbro0.png");
  hammerb[1] = loadImage("hammerbro1.png");
}

void loadWorld(PImage img) {
  world = new FWorld(-2600, -2600, 2600, 2600);
  world.setGravity(0, 900);

  for (int y = 0; y < map.height; y++) {
    for (int x = 0; x < map.width; x++) {
      color c = img.get(x, y);
      FBox b = new FBox(gridSize, gridSize);
      b.setPosition(x*gridSize, y*gridSize);
      b.setStatic(true);
      if (c == black) {
        b.attachImage(stone);
        b.setFriction(21);
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
        b.setName("treetrunk");
        world.add(b);
      } else if (c == #00FF00) {
        b.attachImage(treetopm);
        b.setName("treetopw");
        b.setFriction(6);
        world.add(b);
      } else if (c == #095D02) {
        b.attachImage(treetopl);
        b.setFriction(6);
        b.setName("treetopL");
        world.add(b);
      } else if (c == #2FA025) {
        b.attachImage(treetopr);
        b.setFriction(6);
        b.setName("treetopr");
        world.add(b);
      } else if (c == #5D2400) {
        FBridge br = new FBridge(x*gridSize, y*gridSize);
        terrain.add(br);
        br.attachImage(bridgec);
        br.setName("bridge");
        world.add(br);
      } else if (c == #A2A2A2) {
        b.attachImage(spike);
        b.setName("spikes");
        b.setPosition(x*gridSize, y*gridSize+2);
        world.add(b);
      } else if (c == pink) {
        b.attachImage(bridgeintersection);
        b.setName("intersec");
        world.add(b);
      } else if (c == reds) {
        FSpring sp = new FSpring(x * gridSize, y * gridSize);
        terrain.add(sp);
        world.add(sp);
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
        b.setFriction(18);
      } else if (c == browny) {
        FGoomba gmb = new FGoomba(x*gridSize, y*gridSize);
        enemies.add(gmb);
        world.add(gmb);
      } else if (c==#900000) {
        FHammer hb = new FHammer(x*gridSize, y*gridSize);
        enemies.add(hb);
        world.add(hb);
      } else if (c== dirtyellow) {
        portalIn = new FPortal(x*gridSize, y*gridSize);
        terrain.add(portalIn);
        portalIn.attachImage(chute1);
        portalIn.setFriction(6);
        portalIn.setName("FPortals");
        world.add(portalIn);
      } else if (c== red) {
        portalOut = new FPortalO(x*gridSize, y*gridSize);
        terrain.add(portalOut);
        portalOut.attachImage(chute2);
        portalOut.setFriction(6);
        portalOut.setName("FPortalO");
        world.add(portalOut);
      } else if (c == #FF7D00) {
        FLava lav = new FLava(x*gridSize, y*gridSize);
        terrain.add(lav);
        world.add(lav);
      } else if (c== #0000FF) {
        FWater wa = new FWater(x*gridSize, y*gridSize);
        terrain.add(wa);
        world.add(wa);
      } else if (c == #B4B4B4) {
        FThwomp thw = new FThwomp(gridSize*x+10+6, gridSize*y+10+6);
        enemies.add(thw);
        world.add(thw);
      } else if (c == #830000) {
        FLuckyBox lb = new FLuckyBox(gridSize*x, gridSize*y);
        terrain.add(lb);
        world.add(lb);
      } else if (c == #500000) {
        FLifeBox lib = new FLifeBox(gridSize*x, gridSize*y);
        terrain.add(lib);
        world.add(lib);
      } else if (c == #007E83) {
        FKoopa kp = new FKoopa(gridSize*x, gridSize*y);
        enemies.add(kp);
        world.add(kp);
      } else if (c == #100000) {
        b.attachImage(one);
        b.setPosition(x*gridSize-4, y*gridSize);
        b.setName("one");
        b.setFriction(6);
        world.add(b);
      } else if (c == #200000) {
        b.attachImage(two);
        b.setName("two");
        b.setFriction(6);
        world.add(b);
      } else if (c == #300000) {
        b.attachImage(three);
        b.setName("three");
        b.setFriction(6);
        world.add(b);
      } else if (c == #400000) {
        b.attachImage(four);
        b.setPosition(x*gridSize+4, y*gridSize);
        b.setName("four");
        b.setFriction(6);
        world.add(b);
      } else if (c == #AA00FF) {
        FBox cp = new FBox(gridSize, gridSize);
        cp.setPosition(x * gridSize, y * gridSize);
        cp.setStatic(true);
        cp.setSensor(true);
        cp.attachImage(lilguy);
        cp.setName("checkpoint");
        world.add(cp);
      } else if (c==#990000) {
        b.setPosition(x*gridSize, y*gridSize);
        b.setName("finishs");
        b.attachImage(finish);
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
  for (int i = fireballs.size() - 1; i >= 0; i--) {
    FCircle fb = fireballs.get(i);

    if (fb.getY() > 3000 || fb.getX() < -3000 || fb.getX() > 3000) {
      world.remove(fb);
      fireballs.remove(i);
    }

    if (player.isssTouching(fb, "goomba") || player.isssTouching(fb, "koopa") || player.isssTouching(fb, "Hammerbro")) {
      world.remove(fb);
      fireballs.remove(i);
    }
    if (times100 <=0) {
      world.remove(fb);
      fireballs.remove(i);
    }
  }
}

void drawWorld() {
  pushMatrix();
  translate(-player.getX()+width/2, -player.getY()+height/2);
  world.step();
  world.draw();
  popMatrix();
}

void heartDrop(float x, float y) {
  if (hdrop != null) return;

  hdrop = new FCircle(10);
  hdrop.setPosition(x, y);
  hdrop.setVelocity(random(-200, 200), -300);
  hdrop.setName("heartdrop");
  hdrop.setRotatable(false);
  hdrop.setStatic(false);
  hdrop.setSensor(false);
  hdrop.setDensity(2);
  hdrop.setFriction(0.2);
  hdrop.setRestitution(0.5);
  hdrop.attachImage(heart);

  world.add(hdrop);
}

void checkhDropRemove() {
  if (heartdrops && hdrop != null) {
    world.remove(hdrop);
    hdrop = null;
    heartdrops = false;
  }
}

void sDrop(float x, float y) {
  if (drop != null) return;

  drop = new FCircle(10);
  drop.setPosition(x, y);
  drop.setVelocity(random(-200, 200), -300);
  drop.setName("drop");
  drop.setRotatable(false);
  drop.setStatic(false);
  drop.setSensor(false);
  drop.setDensity(2);
  drop.setFriction(0.2);
  drop.setRestitution(0.5);
  drop.attachImage(star);
  world.add(drop);
}

void checkDropRemove() {
  if (drops && drop != null) {
    world.remove(drop);
    drop = null;
    drops = false;
  }
}

void KoopaDrop(float x, float y) {
  if (kdrop != null) return;
  kdrop = new FCircle(20);
  kdrop.setPosition(x, y);
  kdrop.setVelocity(random(-200, 200), -30);
  kdrop.setStatic(false);
  kdrop.setSensor(false);
  kdrop.setDensity(2);
  kdrop.setFriction(0.2);
  kdrop.setRestitution(0.5);
  kdrop.attachImage(shell);
  kdrop.setName("koopadrop");
  world.add(kdrop);
}

void checkKDropRemove() {
  if (koopadrops && kdrop != null) {
    world.remove(kdrop);
    koopadrops = false;
    kdrop = null;
  }
}

void shootfireball() {
  FCircle fb = new FCircle(14);
  fb.setPosition(player.getX(), player.getY());
  fb.setName("fireball");
  fb.setRotatable(true);
  fb.setStatic(false);
  fb.setSensor(false);
  fb.setDensity(1);
  fb.setFriction(0.2);
  fb.setAngularVelocity(random(0, 40));
  fb.attachImage(fireball);
  fb.setRestitution(0.9);
  int dir = 1;
  if (player.getVelocityX() < 0) dir = -1;

  fb.setVelocity(500 * dir, -50);

  world.add(fb);
  fireballs.add(fb);
}

int lives, mode;
final int INTRO = 0;
final int GAME = 1;
final int PAUSE = 2;
final int GAMEWIN = 3;
final int GAMEOVER = 4;

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
color dirtyellow = #9B9A7E;
