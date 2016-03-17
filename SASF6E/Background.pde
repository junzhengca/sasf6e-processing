/* Copyright Jun Zheng All Rights Reserved
 * This work is licensed under a Creative Commons Attribution 4.0 International License.
 * Used to show circle effects in the background
 */
class Background {
  
  float x,y,size,currentSize,r,g,b;
  
  Background() {
    this.genNewEllipse();
  }
  
  void update(){
    noStroke();
    translate(0,0,-50);
    ellipseMode(CENTER);
    float opacity = 1 - this.currentSize / this.size;
    fill(color(this.r,this.g,this.b,255 * opacity)); //Fadeout the ellipse
    ellipse(this.x,this.y,this.currentSize,this.currentSize);
    this.currentSize++;
    if(this.currentSize > this.size){
      this.genNewEllipse();
    }
    translate(0,0,50);
    tint(255,255);
  }
  
  void genNewEllipse(){
    //Refreash the positon and color of circle
    this.x = random(1280);
    this.y = random(720);
    this.size = random(100,300);
    this.r = random(255);
    this.g = random(255);
    this.b = random(255);
    this.currentSize = 1;
  }
}