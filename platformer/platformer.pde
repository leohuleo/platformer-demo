import fisica.*;
PImage map;
int x, y;
color black = #000000;
color orange = #FF9E00;
int gridSize = 50;
boolean upKey, downKey, leftKey, rightKey, spaceKey, canJump;
int vx, vy;
float cameraX,cameraY;
FWorld world;
FBox player;
FBomb bomb = null;
ArrayList<FContact> playerC;
ArrayList<FBox> boxes;
void setup() {
  cameraX = 0;
  cameraY = 0;
  size(800, 600);
  Fisica.init(this);
  world = new FWorld(-100, -100, 10000, 10000);
  world.setGravity(0, 900);
  map = loadImage("map.png");
  boxes = new ArrayList();
  while (y<map.height) {
    color c = map.get(x, y);
    if (c==black) {
      FBox block = new FBox(gridSize, gridSize);
      block.setPosition(gridSize/2+x*gridSize, gridSize/2+y*gridSize);
      block.setStatic(true);
      block.setName("ground");
      block.setFillColor(black);
      block.setFriction(1);
      boxes.add(block);
      world.add(block);
    }
    if (x==map.width) {
      x = 0;
      y++;
    } else {
      x++;
    }
  }
  player = new FBox(30, 30);
  player.setPosition(50, 200);
  player.setFillColor(#FF0303);
  player.setRotatable(false);
  world.add(player);
}

void draw() {
  background(255);
  pushMatrix();
  translate(-player.getX() + width/2 + cameraX,-player.getY() + height/2 + 100);
  world.step();
  world.draw();
  popMatrix();

  updatePlayer();
}
void updatePlayer() {
  canJump = false;
  vx = 0;
  if (leftKey){
    vx=-300;
    
      if(cameraX>vx/6){
      cameraX-=3;
      }

  }else{
    if(cameraX < 0){
      cameraX+=3;
    }
  }
  if (rightKey){
    vx=300;
      if(cameraX<vx/6){
      cameraX+=3;
      }
  }else{
    if(cameraX > 0){
      cameraX-=3;
    }
  }
  player.setVelocity(vx, player.getVelocityY());

  playerC = player.getContacts();
  if(playerC.size() > 0){
    canJump = true;
  }
  if (upKey && canJump) {
    player.setVelocity(player.getVelocityX(), -400);
  }
  if(spaceKey && bomb == null){
    bomb = new FBomb();
  }
  if(bomb != null){
    bomb.tick();
  }
}
void keyPressed() {
  if (key=='w')upKey=true;
  if (key=='a')leftKey=true;
  if (key=='s')downKey=true;
  if (key=='d')rightKey=true;
  if(key==' ')spaceKey=true;
}

void keyReleased() {
  if (key=='w')upKey=false;
  if (key=='a')leftKey=false;
  if (key=='s')downKey=false;
  if (key=='d')rightKey=false;
  if(key==' ')spaceKey=false;
}
