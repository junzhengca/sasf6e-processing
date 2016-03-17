/* Copyright Jun Zheng All Rights Reserved
 * This work is licensed under a Creative Commons Attribution 4.0 International License.
 * Requires EventManger & Events class
 * Class list
 */
 
class Button {
  public Events em;
  public String buttonText = "default-button", defaultImage, hoverImage, activeImage;
  public java.lang.reflect.Method onclickMethod, mouseoverMethod, mouseoutMethod;
  public Boolean mouseDown = false, mouseOver = false, visiable = true;
  public int[] position, size, padding;
  public color backgroundColor, foregroundColor;
  public int borderRadius;
  public PImage[] imageLib;
  public int[] pointerOffset = new int[]{0,0}; //An ugly fix for 3d ui
  
  Button(Events em, int x, int y, int w, int h, String text, int paddingLeft, int paddingTop, color background, color foreground, int borderRadius){
    this.em = em;
    this.setPosition(new int[]{x,y});
    this.setSize(new int[]{w,h});
    this.setText(text);
    this.setPadding(new int[]{paddingLeft,paddingTop});
    this.setBackgroundColor(background);
    this.setForegroundColor(foreground);
    this.setBorderRadius(borderRadius);
  }
  
  public void setPosition(int[] position){ // Set button position
    this.position = position;
  }
  
  public void setSize(int[] size){ // Set button size
    this.size = size;
  }
  
  public void setText(String text){ // Set button text
    this.buttonText = text; 
  }
  
  public void setPadding(int[] padding){ // Set button text padding, padding[0] is padding-left, padding[1] is padding-top
    this.padding = padding;
  }
  
  public void setBackgroundColor(color c){ // Set button background color
    this.backgroundColor = c;
  }
  
  public void setForegroundColor(color c){ // Set button foreground color
    this.foregroundColor = c;
  }
  
  public void setBorderRadius(int r){ // Set border radius
    this.borderRadius = r;
  }
  
  public void setImages(String defaultImage, String hoverImage, String activeImage){
    try {
      this.imageLib = new PImage[] {
        loadImage(defaultImage),
        loadImage(hoverImage),
        loadImage(activeImage)
      };
    } catch (Exception ex) {
      //print("failed to load image for button : " + ex.toString());
    }
  }
  
  void onclickEvent(String methodName){ // Create an onclick event
    try{
      this.onclickMethod = this.em.getClass().getMethod(methodName,Button.class);
    }
    catch (Exception ex) {
       print(ex.toString());
    }
  }
  
  void mouseoverEvent(String methodName){ // Create a mouseover event
    try{
      this.mouseoverMethod = this.em.getClass().getMethod(methodName,Button.class);
    }
    catch (Exception ex) {
       print(ex.toString());
    }
  }
  
  void mouseoutEvent(String methodName){ // Create a mouseout event
    try{
      this.mouseoutMethod = this.em.getClass().getMethod(methodName,Button.class);
    }
    catch (Exception ex) {
       print(ex.toString());
    }
  }
  
  private void invokeEvent(java.lang.reflect.Method event){ // Invoke an event
    try {
      event.invoke(this.em,this);
    } catch (Exception ex) {
      //print("invoke failed");
    }
  }
  
  void update(){
    noStroke();
    textSize(18);
    fill(this.backgroundColor);
    rect(this.position[0], this.position[1], this.size[0], this.size[1], this.borderRadius);
    if(this.mouseOver){
      try {
        image(this.imageLib[1],this.position[0],this.position[1]);
      } catch (Exception ex) {
        print("failed to display hover image");
      }
    } else {
      try {
        image(this.imageLib[0],this.position[0],this.position[1]);
      } catch (Exception ex) {
        print("failed to display default image");
      } 
    }
    fill(this.foregroundColor);
    textAlign(LEFT, TOP);
    text(this.buttonText, this.position[0] + this.padding[0], this.position[1] + this.padding[1]);
    if(mouseX < this.position[0] + this.size[0] + this.pointerOffset[0]  && mouseY < this.position[1] + this.size[1] + this.pointerOffset[1]  && mouseY > this.position[1] + this.pointerOffset[1]  && mouseX > this.position[0] + this.pointerOffset[0]){
      if(mousePressed){
        this.mouseDown = true;
      } else {
        if(this.mouseDown == true){
          //Invoke click
          this.mouseDown = false;
          this.invokeEvent(this.onclickMethod); //onclick
        } 
      }
      if(!this.mouseOver){
        this.mouseOver = true;
        this.invokeEvent(this.mouseoverMethod); //mouseover
      }
    } else {
      if(mouseOver == true){
        this.mouseOver = false;
        this.invokeEvent(this.mouseoutMethod); //mouseout
      }
    }
    textAlign(LEFT, BASELINE);
  }
}

class PopupWindow {
  float w,h;
  Boolean visiable = false, animationState = false;
  float animationFrame = 0;
  public java.lang.reflect.Method updateMethod;
  Events ev;
  PopupWindow(Events ev,float w, float h){
    this.w = w;
    this.h = h;
    this.ev = ev;
  }
  
  void update(){
    if(this.visiable){
      if(this.animationFrame == 1){
        SoundPlayer sp = new SoundPlayer(dataPath("") + "/popupSound_01.wav");
        try{
          sp.playSound();
        } catch (Exception ex){
          print(ex); 
        }
      }
      
      translate(0,0,90);
      fill(0,0,255,50);
      rect(width / 2 - this.w / 10 * this.animationFrame / 2 - 2,height / 2 - this.h / 10 * this.animationFrame / 2 + 2,this.w / 10 * this.animationFrame,this.h / 10 * this.animationFrame,5);
      translate(0,0,2);
      fill(0,255,0,50);
      rect(width / 2 - this.w / 10 * this.animationFrame / 2 + 2,height / 2 - this.h / 10 * this.animationFrame / 2 + 2,this.w / 10 * this.animationFrame,this.h / 10 * this.animationFrame,5);
      translate(0,0,2);
      fill(255,0,0,50);
      rect(width / 2 - this.w / 10 * this.animationFrame / 2 - 2,height / 2 - this.h / 10 * this.animationFrame / 2 - 2,this.w / 10 * this.animationFrame,this.h / 10 * this.animationFrame,5);
      
      translate(0,0,6);
      
      fill(255,255,255,50);
      rect(width / 2 - this.w / 10 * this.animationFrame / 2,height / 2 - this.h / 10 * this.animationFrame / 2,this.w / 10 * this.animationFrame,this.h / 10 * this.animationFrame,5);
      
      translate(0,0,-100);
      if(!this.animationState && this.animationFrame < 12) this.animationFrame++;
      if(this.animationFrame == 12) this.animationState = true;
      if(this.animationState && this.animationFrame > 10) this.animationFrame-=0.2;
      try {
        this.updateMethod.invoke(this.ev,this);
      } catch (Exception ex) {
        print("invoke failed\n");
      }
    }
    
  }
  
  void updateEvent(String methodName){
    try{
      this.updateMethod = this.ev.getClass().getMethod(methodName,PopupWindow.class);
    }
    catch (Exception ex) {
       print(ex.toString());
    }
  }
}

class BoxCollision extends PointCollision {
  Boolean debug = false;
  BoxCollision(){ } //Nothing to initialize
  
  Boolean detectBoxCollision(float[] aProp, float[] bProp){
    //Detect a collision
    if(debug){
      noFill();
      stroke(46,168,15);
      strokeWeight(2);
      rect(aProp[0],aProp[1],aProp[2],aProp[3]); 
      rect(bProp[0],bProp[1],bProp[2],bProp[3]);
    }
    if(
        detectPointCollision(aProp[0],aProp[1],bProp) ||
        detectPointCollision(aProp[0],aProp[1] + aProp[3],bProp) ||
        detectPointCollision(aProp[0] + aProp[2],aProp[1],bProp) ||
        detectPointCollision(aProp[0] + aProp[2],aProp[1] + aProp[3],bProp)
      ){
      return true;
    } else {
      return false; 
    }
  }
}

class PointCollision {
  PointCollision(){ } //Nothing to initialize
  /*
   *  x1y1 x2y1
   *  x1y2 x2y2
   *  box int[] {x,y,width,height}
   *  x1 = box[0]
   *  x2 = box[0] + box[2]
   *  y1 = box[1]
   *  y2 = box[1] + box[3]
   */
  
  Boolean detectPointCollision(float x, float y, float[] box){
    if( x < box[0] + box[2] && y < box[1] + box[3] && y > box[1] && x > box[0] ) return true;
    return false;
  }
}

class AsyncHttpRequest {
  //Do an async http request, like ajax. Using threads
  Events ev;
  String requestUrl = "", postData = "", resultData = "";
  int resultCode;
  Thread thread;
  AsyncHttpRequestRunnable ahrr;
  Boolean joined = false;
  public java.lang.reflect.Method finishedMethod;
  
  AsyncHttpRequest(Events ev){
    this.ev = ev;
  }
  
  void prepare(String url, String postData, String finishedEvent){
    this.requestUrl = url;
    this.postData = postData;
    try { //Get the finished method to invoke
      this.finishedMethod = this.ev.getClass().getMethod(finishedEvent,AsyncHttpRequest.class);
    }
    catch (Exception ex) {
       print(ex.toString());
    }
  }
  
  void execute(){
    this.joined = false;
    this.ahrr = new AsyncHttpRequestRunnable(this.requestUrl, this.postData); //Create a runnable, so we can access later
    this.thread = new Thread(ahrr);
    this.thread.start();
  }
  
  void update(){
    try {
      if (!this.thread.isAlive() && !this.joined) { //Check if thread has died
        this.joined = true;
        this.thread.join();
        this.resultData = this.ahrr.responseData;
        this.resultCode = this.ahrr.responseCode;
        try {
          this.finishedMethod.invoke(this.ev,this);
        } catch (Exception ex) {
          print("invoke failed\n");
        }
      }
    } catch (Exception ex) {
      print(ex); 
    }
  }
}

class AsyncHttpRequestRunnable implements Runnable {
  String url,postData;
  String responseData = "";
  int responseCode = 500;
  AsyncHttpRequestRunnable(String url, String postData){
    this.url = url;
    this.postData = postData;
  }
  
  public void run(){ //Begin a post request
    try {
      Thread.sleep(3500);
      URL obj = new URL(this.url);
      HttpURLConnection con = (HttpURLConnection) obj.openConnection();
      con.setRequestMethod("POST");
      con.setRequestProperty("User-Agent", "Mozilla/5.0");
      con.setRequestProperty("Accept-Language", "en-US,en;q=0.5");
      String urlParameters = this.postData;
      con.setDoOutput(true);
      DataOutputStream wr = new DataOutputStream(con.getOutputStream());
      wr.writeBytes(urlParameters);
      wr.flush();
      wr.close();
      int responseCode = con.getResponseCode();
      BufferedReader in = new BufferedReader(
              new InputStreamReader(con.getInputStream()));
      String inputLine;
      StringBuffer response = new StringBuffer();
      while ((inputLine = in.readLine()) != null) {
        response.append(inputLine);
      }
      in.close();
      this.responseData = response.toString();
      this.responseCode = responseCode;
    } catch (Exception ex){
      print(ex); 
    }
  }
}

class ControlTip {
  Boolean visiable = false;
  String text = "";
  float rightMargin = 0;
  
  ControlTip(){
    
  }
  
  void setText(String text, float rightMargin){
    this.text = text;
    this.rightMargin = rightMargin;
  }
  
  void show(){
    this.visiable = true;  
  }
  
  void hide(){
    this.visiable = false;  
  }
  
  void update(){
    if(this.visiable){
      textSize(16);
      fill(255);
      text(this.text,1280 - this.rightMargin,680);
    }
  }
}

class SoundPlayer {
  File soundFile;
  AsyncSoundPlayer asp;
  Thread thread;
  SoundPlayer(String fileName){
    try {
      this.soundFile = new File(fileName);
    }catch (Exception ex){
      print("Failed to load sound\n");
      print(ex + "\n");
    }
  }
  
  void playSound() {
    this.asp = new AsyncSoundPlayer(this.soundFile); //Create a runnable, so we can access later
    this.thread = new Thread(asp);
    this.thread.start();
  }
}

class AsyncSoundPlayer implements Runnable {
  File soundFile;
  AsyncSoundPlayer(File soundFile){
    this.soundFile = soundFile;
  }
  
  void run(){
    try {
      AudioListener listener = new AudioListener();
      AudioInputStream audioInputStream = AudioSystem.getAudioInputStream(this.soundFile);
      try {
        Clip clip = AudioSystem.getClip();
        clip.addLineListener(listener);
        clip.open(audioInputStream);
        try {
          clip.start();
          listener.waitUntilDone();
        } finally {
          clip.close();
        }
      } finally {
        audioInputStream.close();
      }
    } catch (Exception ex){
      //print(ex);
    }
  }
}


class AudioListener implements LineListener {
  private boolean done = false;
  @Override public synchronized void update(LineEvent event) {
    Type eventType = event.getType();
    if (eventType == Type.STOP || eventType == Type.CLOSE) {
      done = true;
      notifyAll();
    }
  }
  public synchronized void waitUntilDone() throws InterruptedException {
    while (!done) {
      wait();
    }
  }
}