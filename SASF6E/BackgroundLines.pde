/* Copyright Jun Zheng All Rights Reserved
 * This work is licensed under a Creative Commons Attribution 4.0 International License.
 * Used to show gradient lines in the background
 * PLEASE do not use more then 50 lines
 * TESTED : Core i7 4790 @ 3.60Ghz Will only render 15 frames per second when generating 100 lines
 */
class BackgroundLines {
  BackgroundLine[] bl = new BackgroundLine[50];
  BackgroundLines(){
    int[] currentBegin = new int[]{0,0};
    int[] currentEnd = new int[]{0,0};
    for(int i=0;i<50;i++){
      currentBegin[0] = currentEnd[0];
      currentBegin[1] = currentEnd[1];
      currentEnd[0] = currentBegin[0] + int(random(200,600) - 400);
      currentEnd[1] = currentBegin[1] + int(random(40,300));
      this.bl[i] = new BackgroundLine(color(int(random(0,255)),int(random(0,255)),int(random(0,255))),color(int(random(0,100)),int(random(0,100)),int(random(0,100))),currentBegin,currentEnd);
      if(currentEnd[0] > 1280 || currentEnd[1] > 720){
        currentEnd = new int[]{int(random(0,1280)),0};
      }
    }
  }
  
  void update(){
    for(int i=0;i<50;i++){
      this.bl[i].update();
    }
  }
}

class BackgroundLine {
  int totalFrame; int currentFrame = 0;
  int[] b,e;
  color[] c;
  float[] offsets;
  BackgroundLine(color colorA, color colorB, int[] beginPos, int[] endPos){
    this.drawGradientLine(
      new int[]{beginPos[0],beginPos[1]},
      new int[]{endPos[0],endPos[1]},
      new color[]{colorA,colorB}
    );
  }
  
  void drawGradientLine(int[] b, int[] e, color[] c){
    noFill();
    this.b = b; this.e = e; this.c = c;
    float len = sqrt(pow((e[0] - b[0]),2) + pow((e[1] - b[1]),2)); //Calculate the length
    float[] offsets = new float[]{(e[0] - b[0]) / len,(e[1] - b[1]) / len}; //Offsets of x,y
    this.offsets = offsets;
    this.totalFrame = int(len);
  }
  
  void update(){
    if(this.currentFrame <= this.totalFrame){
      this.currentFrame+=5;
    }
    for(int i=0;i<this.currentFrame;i++){
      color lerpC = lerpColor(c[0], c[1], float(i) / float(this.totalFrame));
      noStroke(); fill(lerpC);
      ellipse(b[0] + offsets[0] * i,b[1] + offsets[1] * i,3,3);
    }
  }

}