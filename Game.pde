class Game {
  HashMap<String, PopupWindow> popupWindows = new HashMap<String, PopupWindow>();
  HashMap<String, AsyncHttpRequest> asyncHttpRequests = new HashMap<String, AsyncHttpRequest>();
  Events events = new Events();
  int state = 0, loadingFrame = 0;
  boolean resourceLoaded = false;
  boolean versionWindowVisiable = false;
  ControlTip controlTip;
  boolean keyDown = false;
  char currentKey;
  Menu m;
  PixelPlane pp;
  ScoreBoard sb;
  StatusPanel sp;
  Bullets b;
  boolean levelInitialized = false;
  int currentLevel = 1;
  Game(){
    this.beginResourceLoad(true);
    this.controlTip = new ControlTip();
    m = new Menu(this.events);
    //this.beginServerCheck(true,true);
    SoundPlayer sp = new SoundPlayer(dataPath("") + "/menuMusic_01.wav");
    try{
      sp.playSound();
    } catch (Exception ex){
      print(ex); 
    }
  }
  
  void update() {
    if(keyPressed){
      this.keyDown = true;
      currentKey = key;
    }
    if(!keyPressed && this.keyDown){
      this.keyDown = false;
      if(this.currentKey == ' '){
        this.events.keySpace_Pressed(); 
      }
    }
    for (PopupWindow window : this.popupWindows.values()) {
      window.update();
    }
    for (AsyncHttpRequest request : this.asyncHttpRequests.values()) {
      request.update();
    }
    if(loadingFrame == 200){
      if(!resourceLoaded){
        this.beginResourceLoad(false);
        this.resourceLoaded = true;
      }
    }
    if(this.state == 5){
      this.m.update(); 
    }
    if(this.state == 6){
      this.pp.update();
      this.sb.update();
      this.sp.update();
      this.b.update();
      this.sb.gameBegan = true;
      
      //This could be optimized.. but hey, it's virtually impossible to pass level 3...
      if(currentLevel == 1){
        if(!levelInitialized){
          b.generateBullets(200,2);
          this.levelInitialized = true;
        }
        if(sb.currentTime == 1400){
          currentLevel++;
          levelInitialized = false;
        }
      } else if (currentLevel == 2){
        if(!levelInitialized){
          b.generateBullets(400,2);
          this.levelInitialized = true;  
        }
        if(sb.currentTime == 3400){
          currentLevel++;
          levelInitialized = false;
        }
      } else if (currentLevel == 3){
        if(!levelInitialized){
          b.generateBullets(800,2);
          this.levelInitialized = true;  
        }
        if(sb.currentTime == 7000){
          currentLevel++;
          levelInitialized = false;
        }
      } else if (currentLevel == 4){
        if(!levelInitialized){
          b.generateBullets(800,1);
          this.levelInitialized = true;  
        }
        if(sb.currentTime == 8800){
          currentLevel++;
          levelInitialized = false;
        }
      } else if (currentLevel == 5){
        if(!levelInitialized){
          b.generateBullets(1600,1);
          this.levelInitialized = true;  
        }
        if(sb.currentTime == 12200){
          currentLevel++;
          levelInitialized = false;
        }
      } else if (currentLevel == 6){
        if(!levelInitialized){
          b.generateBullets(1600,0.5);
          this.levelInitialized = true;  
        }
        if(sb.currentTime == 14000){
          currentLevel++;
          levelInitialized = false;
        }
      }
    }
    if(this.state == 7){
      //Game over lol 
    }
    this.controlTip.update();
  }
  
  void beginServerCheck(Boolean state, Boolean result){ //Perform an internet connection check
    if(state){
      this.state = 3;
      this.popupWindows.put("checkingServerWindow",new PopupWindow(this.events,400,50));
      this.popupWindows.get("checkingServerWindow").updateEvent("loadingWindow_Update");
      this.popupWindows.get("checkingServerWindow").visiable = true;
      this.asyncHttpRequests.put("checkServerRequest",new AsyncHttpRequest(this.events));
      this.asyncHttpRequests.get("checkServerRequest").prepare("http://www.kiroshiime.com","p=main","serverCheck_Finished");
      this.asyncHttpRequests.get("checkServerRequest").execute();
    } else {
      this.state = 4;
      this.popupWindows.remove("checkingServerWindow");
      if(result){
        this.popupWindows.put("serverCheckStatusWindow",new PopupWindow(this.events,400,300));
        this.popupWindows.get("serverCheckStatusWindow").updateEvent("serverCheckSuccessfulWindow_Update");
        this.popupWindows.get("serverCheckStatusWindow").visiable = true;
      } else {
        this.popupWindows.put("serverCheckStatusWindow",new PopupWindow(this.events,400,300));
        this.popupWindows.get("serverCheckStatusWindow").updateEvent("serverCheckFailedWindow_Update");
        this.popupWindows.get("serverCheckStatusWindow").visiable = true;
      }
      this.controlTip.setText("Press [space] to continue",250);
      this.controlTip.show();
    }
  }
  
  void beginResourceLoad(Boolean state){
    if(state){
      this.state = 1;
      this.popupWindows.put("loadingResourceWindow",new PopupWindow(this.events,400,50));
      this.popupWindows.get("loadingResourceWindow").updateEvent("loadingResourceWindow_Update");
      this.popupWindows.get("loadingResourceWindow").visiable = true; 
    } else {
      this.state = 2;
      this.popupWindows.remove("loadingResourceWindow");
      this.beginServerCheck(true,false);
    }
  }
  
  void showGameoverWindow(){
    this.state = 7;
    this.popupWindows.put("gameoverWindow",new PopupWindow(this.events,400,50));
    this.popupWindows.get("gameoverWindow").updateEvent("gameoverWindow_Update");
    this.popupWindows.get("gameoverWindow").visiable = true; 
  }
  
  void showVersionWindow(){
    this.versionWindowVisiable = true;
    //this.state = 6;
    this.popupWindows.put("versionWindow",new PopupWindow(this.events,400,250));
    this.popupWindows.get("versionWindow").updateEvent("versionWindow_Update");
    this.popupWindows.get("versionWindow").visiable = true; 
    this.controlTip.setText("Press [space] to close",250);
    this.controlTip.show();
  }
  
  void showMainMenu(){
    this.state = 5;
    this.popupWindows.remove("serverCheckStatusWindow");
    this.controlTip.hide();
  }
}