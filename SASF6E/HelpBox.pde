class HelpBox {
  PImage background, textImage;
  Button startButton;
  Events ev;
  Boolean hidden = false;
  HelpBox(Events ev){
    this.ev = ev;
    this.background = loadImage("image/controlsBox.png");
    this.textImage = loadImage("image/controlsImage.png");
    this.startButton  = new Button(this.ev, 
                            width / 2 - 50,500,100,60, //Size & Position
                            "", 
                            25,10,          //Padding
                            color(255,255,255,0),color(0,0,0),0);
    this.startButton.setImages("image/startButton.png","image/startButton_hover.png","image/startButton.png");
    this.startButton.onclickEvent("startButton_Click");
  }
  
  void update(){
    if(!this.hidden){
      translate(width / 2 - 150,100,20);
      image(this.background,0,0);
      text("basic controls",35,50);
      image(this.textImage,60,100);
      translate(-(width / 2 - 150),-100,-20);
      this.startButton.update();
    }
  }
  
  void hide(){
     this.hidden = true;
  }
}