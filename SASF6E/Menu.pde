/* Copyright Jun Zheng All Rights Reserved
 * This work is licensed under a Creative Commons Attribution 4.0 International License.
 * A menu used to switch element type
 */
 
class Menu {
  Events ev;
  Button loginButton, quitButton, startButton;
  PImage logoImage;
  Menu(Events ev){
    this.ev = ev;
    this.logoImage = loadImage("data/logo.png");
    this.loginButton = new Button(this.ev,210,500,257,47,"",0,0,color(255,255,255,0),color(255,255,255,0),0);
    this.loginButton.setImages("data/loginButton.png","data/loginButton_hover.png","data/loginButton.png");
    this.quitButton = new Button(this.ev,510,500,257,47,"",0,0,color(255,255,255,0),color(255,255,255,0),0);
    this.quitButton.setImages("data/quitButton.png","data/quitButton_hover.png","data/quitButton.png");
    this.startButton = new Button(this.ev,810,500,257,47,"",0,0,color(255,255,255,0),color(255,255,255,0),0);
    this.startButton.setImages("data/startButton.png","data/startButton_hover.png","data/startButton.png");
    this.startButton.onclickEvent("startButton_Click");
  }
  
  void update(){
    translate(0,0,10);
    fill(255,255,255,7);
    rect(-400,-400,2080,1520);
    translate(0,0,10);
    image(this.logoImage,width / 2 - 420,200);
    this.loginButton.update();
    this.quitButton.update();
    this.startButton.update();
    fill(255);
    textSize(12);
    text("version alpha 0.08 © Jun Zheng All Rights Reserved\nOnline services powered by kiroshiime.com",100,100);
    translate(0,0,-20);
  }
}