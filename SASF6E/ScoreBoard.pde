class ScoreBoard {
  PImage background;
  String healthText = "100";
  int currentTime = 0;
  Boolean gameBegan = false;
  
  ScoreBoard(){
    this.background = loadImage("data/scoreBoard.png");
  }
  
  void update(){
    translate(50,50,0);
    image(background,0,0);
    textSize(16);
    fill(255);
    text(Integer.toString(this.currentTime),20,25);
    translate(-50,-50,0);
    if(gameBegan) this.currentTime++;
  }
  
  void changeHealthText(String newText){
    this.healthText = newText;
  }
}