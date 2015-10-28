class Bullets {
  PImage bulletImage;
  float[][] bulletProperties = new float[10000][6];
  int currentFrame = 0;
  int currentTotalBullets = 0;
  Bullets(){
    this.bulletImage = loadImage("data/bulletImage.png");
  }
  
  void update(){
    for(int i = 0; i < this.currentTotalBullets; i++){
      if(this.bulletProperties[i][5] == 1){
        if(this.currentFrame >= this.bulletProperties[i][3]){
          translate(0,0,this.bulletProperties[i][4]);
          image(this.bulletImage,this.bulletProperties[i][0],this.bulletProperties[i][1]);
          this.bulletProperties[i][1]+=this.bulletProperties[i][2];
          if(this.bulletProperties[i][1] > 800 || this.bulletProperties[i][1] == 0){ //This is a invalid bullet
            this.bulletProperties[i][5] = 0;
          }
          translate(0,0,-this.bulletProperties[i][4]);
        }
      }
    }
    this.currentFrame++;
  }
  
  void generateBullets(int totalBullets, float delay){
    for(int i = 0; i < totalBullets; i++){
      this.bulletProperties[i][0] = random(1,1280);
      this.bulletProperties[i][1] = 0;
      this.bulletProperties[i][2] = random(5,i * 0.02); //Speed
      this.bulletProperties[i][3] = random(1,totalBullets * delay * 2); //Delay
      this.bulletProperties[i][4] = random(0,0) - 0; //z-translate
      this.bulletProperties[i][5] = 1; //a valid bullet
    } 
    this.currentFrame = 0;
    this.currentTotalBullets = totalBullets;
  }
}