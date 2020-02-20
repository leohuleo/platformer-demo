class FBomb extends FBox{
  
  int timer;
  
  FBomb(){
    super(gridSize,gridSize);
    this.setPosition(player.getX() + gridSize, player.getY());
    this.setFillColor(orange);
    timer = 60;
    world.add(this);
  }
  
  void tick(){
    if(timer >0){
      timer--;
    }else{
      explode();
      world.remove(this);
    }
  }
  
  void explode(){
    for(int i = 0;i<boxes.size();i++){
      FBox b = boxes.get(i);
      if(dist(this.getX(),this.getY(),b.getX(),b.getY()) < 500){
        b.setStatic(false);
        bomb = null;
        float vx = -1*(this.getX() - b.getX());
        float vy = -1*(this.getY() - b.getY());
        b.setVelocity(vx,vy);
      }
    }
  }
}
