/* Copyright Jun Zheng All Rights Reserved
 * This work is licensed under a Creative Commons Attribution 4.0 International License.
 * Stores all events
 */

//Key events binding
void keyPressed(){
  if (key == 'a' || key == 'A') g.events.keyA_Down();
  else if (key == 'd' || key == 'D') g.events.keyD_Down();
  else if (key == 'w' || key == 'W') g.events.keyW_Down();
  else if (key == 's' || key == 'S') g.events.keyS_Down();
}

void keyReleased(){
  if (key == 'a' || key == 'A') g.events.keyA_Up();
  else if (key == 'd' || key == 'D') g.events.keyD_Up();
  else if (key == 'w' || key == 'W') g.events.keyW_Up();
  else if (key == 's' || key == 'S') g.events.keyS_Up();
}
 
class EventManager {
  EventManager(){
    //Nothing yet
  }
}

class Events extends EventManager {
  //Here stores all events
  HashMap<String,PImage> imageMap = new HashMap<String,PImage>();
  Events(){
    this.imageMap.put("serverConnected",loadImage("data/serverConnected.png"));
    this.imageMap.get("serverConnected").resize(400,300);
    this.imageMap.put("serverDisconnected",loadImage("data/serverDisconnected.png"));
    this.imageMap.get("serverDisconnected").resize(400,300);
  }
  public void squareButton_Click(Button obj){
    Boolean pass = false;
    while(!pass){
      try {
        JFrame frame = new JFrame("Square Size");
        frame.setAlwaysOnTop(true);
        String size = JOptionPane.showInputDialog(frame, "What's the size of squares you wish to have?");
        int s = Integer.parseInt(size);
        pass = true;
        //elm.size = s;
        //elm.type = "square";
      } catch (Exception ex){
        pass = false;
      }
    }
  }
  
  public void circleButton_Click(Button obj){
    Boolean pass = false;
    while(!pass){
      try {
        JFrame frame = new JFrame("Sphere Size");
        frame.setAlwaysOnTop(true);
        String size = JOptionPane.showInputDialog(frame, "What's the size of spheres you wish to have?");
        int s = Integer.parseInt(size);
        pass = true;
        //elm.size = s;
        //elm.type = "circle";
      } catch (Exception ex){
        pass = false;
      }
    }
  }
  
  public void startButton_Click(Button obj){
    //Start a new game
    g.pp = new PixelPlane();
    g.sb = new ScoreBoard();
    g.sp = new StatusPanel();
    g.b = new Bullets();
    g.currentLevel = 1;
    g.state = 6;
    g.levelInitialized = false;
  }
  
  public void loadingWindow_Update(PopupWindow obj){
    translate(0,0,105);
    fill(255);
    textSize(12);
    text("Please wait while we communicate with the server...\nConnecting to api.kiroshiime.com",width / 2 - 150,height / 2 - 7);
    translate(0,0,-105);
  }
  
  public void serverCheckSuccessfulWindow_Update(PopupWindow obj){
    translate(0,0,105);
    fill(255);
    textSize(12);
    text("You are now connected to Server - Tokyo Japan, upload\nyour data to the cloud, and compete against players\naround the world.",width / 2 - 160,250);
    image(this.imageMap.get("serverConnected"),width / 2 - 200,220);
    translate(0,0,-105);
  }
  
  public void serverCheckFailedWindow_Update(PopupWindow obj){
    translate(0,0,105);
    fill(255);
    textSize(12);
    text("Failed to connect\nPlease check your internet connection and try again\nError - FC001\nYou can start the game offline",width / 2 - 160,250);
    image(this.imageMap.get("serverDisconnected"),width / 2 - 200,250);
    translate(0,0,-105);
  }
  
  public void loadingResourceWindow_Update(PopupWindow obj){
    translate(0,0,105);
    fill(255);
    textSize(12);
    text("Loading Resources...\nLoading resources from /data",width / 2 - 150,height / 2 - 7);
    translate(0,0,-105);
    g.loadingFrame++;
  }
  
  public void versionWindow_Update(PopupWindow obj){
    translate(0,0,105);
    fill(255);
    textSize(12);
    text("You are playing version alpha 0.08\nWith server version alpha 0.01\n\n***KNOWN BUGS***\n-java.lang.StackOverflowError sometimes thrown\n-Press wasd at the beginning will cause crash\n-Background music will not loop\n-Lags even on my i7 workstation",width / 2 - 150,height / 2 - 70);
    translate(0,0,-105);
  }
  
  public void gameoverWindow_Update(PopupWindow obj){
    translate(0,0,105);
    fill(255);
    textSize(12);
    text("GAME OVER\nYour score is - " + g.sb.currentTime,width / 2 - 150,height / 2 - 7);
    translate(0,0,-105);
  }
  
  public void serverCheck_Finished(AsyncHttpRequest obj){
    if(obj.resultCode == 200){
      g.beginServerCheck(false,true);
    } else {
      g.beginServerCheck(false,false);
    }
  }
  
  public void keySpace_Pressed(){
    if(g.state == 4){
      g.showMainMenu();
      g.showVersionWindow();
    }
    else if (g.versionWindowVisiable){
      g.popupWindows.remove("versionWindow");
      g.versionWindowVisiable = false;
      g.controlTip.hide();
    }
    else if(g.state == 7){
      g.showMainMenu();
      g.popupWindows.remove("gameoverWindow");
    }
  }
  
  public void keyW_Down(){
    g.pp.movingForward = true;
  }
  
  public void keyW_Up(){
    g.pp.movingForward = false;
  }
  
  public void keyA_Down(){
    g.pp.movingLeft = true;
  }
  
  public void keyA_Up(){
    g.pp.movingLeft = false;
  }
  
  public void keyD_Down(){
    g.pp.movingRight = true;
  }
  
  public void keyD_Up(){
    g.pp.movingRight = false;
  }
  
  public void keyS_Down(){
    g.pp.movingBackward = true;
  }
  
  public void keyS_Up(){
    g.pp.movingBackward = false;
  }
}