class StatusPanel {
  PImage background;
  String currentHealth = "100";
  
  StatusPanel(){
    this.background = loadImage("data/statusPanel.png");
  }
  
  void update(){
    translate(950,550,0);
    image(background,0,0);
    textSize(40);
    textMode(SHAPE);
    fill(255,255,255,200);
    text(this.currentHealth + ".lv" + g.currentLevel,30,80);
    rect(55,109,185,7);
    translate(-950,-550,0); 
  }
  
  void updateHealth(int newHealth){
    this.currentHealth = Integer.toString(newHealth);
  }
  
}