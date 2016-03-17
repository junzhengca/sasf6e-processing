class PixelPlane {
  PImage plane;
  int leftOffset = 37, topOffset = 600, zOffset = 0;
  Boolean movingLeft = false, movingRight = false, movingForward = false, movingBackward = false;
  BoxCollision bc;
  int health = 100;
  
  PixelPlane(){
    this.plane = loadImage("data/pixelPlane.png");
    this.bc = new BoxCollision();
    this.bc.debug = false; //if you want to see debug lines
  }
  
  void update(){
    translate(width/2 - this.leftOffset,this.topOffset,zOffset);
    image(this.plane,0,0);
    translate(-(width/2 - this.leftOffset),-this.topOffset,-zOffset);
    if(this.movingLeft) this.leftOffset+=9; 
    if(this.movingRight) this.leftOffset-=9; 
    if(this.movingForward) this.topOffset-=9; 
    if(this.movingBackward) this.topOffset+=9;
    for(int i = 0; i < g.b.currentTotalBullets; i++){
      if(g.b.bulletProperties[i][5] == 1){
        if(bc.detectBoxCollision(new float[]{width/2 - this.leftOffset + 5,this.topOffset,60,60},
                     new float[]{g.b.bulletProperties[i][0],g.b.bulletProperties[i][1],30,30})){
            this.changeHealthBy(-10);
            g.b.bulletProperties[i][5] = 0;
        }
      }
    }
  }
  
  void changeHealthBy(int value){
    this.health += value;
    g.sp.updateHealth(this.health);
    if(this.health <= 0){
      g.state = 7;
      g.showGameoverWindow();
    }
  }
}