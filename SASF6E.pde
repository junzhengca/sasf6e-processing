/* A cool scene drawn using processing
 * Click on screen to add more elements, click on menu to switch element type
 * Copyright Jun Zheng All Rights Reserved
 * This work is licensed under a Creative Commons Attribution 4.0 International License.
 */
 
/*
 * State variable:
 * Used in Game class
 * Game.state
 * 5 - main menu
 * 6 - game interface
 * 7 - game over
 * 1-4 - load sequence
 */
 
/*
  Version alpha - v0.08
  **KNOWN BUGS**
  -Server check will return true even attempting to check with www.google.com - Because I haven't developed the server yet
  -Lags on Core i7 4790 @ 3.6Ghz with 16GB RAM (WHAAAT?)
  -Press [WASD] before game starts will cause a crash. Because PixelPlane is not initialized
  -java.lang.StackOverflowError sometimes will be thrown. Something to do with depth sort in OpenGL
  **OPTIMIZATIONS TO BE DONE**
  -Smaller music file
  -Join audio threads when done
  -Collision detection optimazations
 */


import javax.swing.*; //Used to show dialogs
import processing.opengl.*; //Seems to have better performance
import java.io.BufferedReader; //Async http requests
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import javax.net.ssl.HttpsURLConnection;
import javax.sound.sampled.*;
import java.io.File;
import java.io.IOException;
import javax.sound.sampled.LineEvent.Type;

Background[] bg = new Background[10];
Game g;

void setup(){
  size(1280,720,P3D);
  hint(ENABLE_DEPTH_SORT);
  frameRate(60);
  textFont(createFont("Arial", 36, false));
  g = new Game();
  for(int i = 0; i < 10; i++) bg[i] = new Background(); //Generate 10 circles in the background
  surface.setTitle("SASF6E - Alpha 0.07");
}



void draw(){
  background(0);
  g.update();
  for(int i = 0; i < 10; i++) bg[i].update();
  camera(width / 2 - (width/2 - mouseX) / 10, height /2 -(height/2 - mouseY) / 10, (height/2.0) / tan(PI*30.0 / 180.0), width/2, height/2, 0.0, 
       0.0, 1.0, 0.0); //Cool 3d viewing effect
}