/* Copyright Jun Zheng All Rights Reserved
 * This work is licensed under a Creative Commons Attribution 4.0 International License.
 * Monitor the framerate, also displays my initial
 */
 
class FramerateMonitor {
  FramerateMonitor(){
    
  }
  
  void update(){
    stroke(255);
    textSize(18);
    fill(0);
    translate(0,0,45);
    line(0,600,1280,600);
    rect(0,600,1280,600);
    fill(255);
    translate(0,0,5);
    text("fps: " + frameRate + "\nJZ", 1050, 610); 
    translate(0,0,-50);
  }
}