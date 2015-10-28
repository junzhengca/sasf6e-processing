/* Copyright Jun Zheng All Rights Reserved
 * This work is licensed under a Creative Commons Attribution 4.0 International License.
 * Show 3d elements, as well convert the UI to 3d
 */
 
class Elements {
  public int size = 50;
  public String type = "square";
  public int[][] pm = new int[1000][6];
  public color[] randColor = new color[1000];
  public int count = 25;
  public int depth = 50;
  Elements(){
    for(int i = 0 ; i < 25; i++){
      this.pm[i] = new int[] { //Initialize first 25 elements
        50 * (i + 1),        //x position
        int(random(0,720)),  //y position
        this.size,           //width
        this.size,           //height
        i % 2,               //move up or down
        int(random(1,3))     //move speed
      };
      this.randColor[i] = color(random(255),random(255),random(255));
    }
  }
  
  public void addElement(int x, int y){
    //Insert a new element in element array
    this.pm[this.count] = new int[] {
      x,y,this.size,this.size,(this.count - 1) % 2,int(random(1,3))
    };
    this.randColor[this.count] = color(random(255),random(255),random(255));
    this.count++;
  }
  
  void update(){
    //Animations
    for(int i = 1; i<this.count;i++){
      noStroke();
      translate(this.pm[i][0],this.pm[i][1], 0);
      if(this.pm[i][4] == 0){ //Move up or down
        this.pm[i][1]+=this.pm[i][5];
      } else {
        this.pm[i][1]-=this.pm[i][5];
      }
      if(this.pm[i][1] > 720 || this.pm[i][1] < 0){
        this.pm[i][4] = (this.pm[i][4] + 1) % 2;
      }
      fill(this.randColor[i]);
      if(this.type == "circle"){ //Draw a sphere or box
        sphereDetail(10);
        sphere(this.size);
      } else {
        box(this.size,this.size, this.depth);
      }
      translate(-this.pm[i][0],-this.pm[i][1], 0); //Reset translate
    }
    
  }
  
  
}