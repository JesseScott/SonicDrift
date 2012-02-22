//-----------------------------------------------------------------------------------------
// State 1 : UI

void State1() {
  if(displayState == 1) {
    background(10);
    strokeWeight(3);
    strokeJoin(ROUND);
    stroke(200);
    fill(200);
    textAlign(LEFT); 
    
    // Pulse for Text
    pulse++;
    if(pulse >= 100) {
      pulse = 0;
    }
    
    // Titling
    fill(255);
    textFont(largeFont);
    text("Sonic Drift", sw/2-(sw/5), sw/10);
    stroke(205);
    line(0, sw/10+5, sw, sw/10+5);
    stroke(155);
    line(0, sw/10+10, sw, sw/10+10);
    stroke(105);
    line(0, sw/10+15, sw, sw/10+15);  
    stroke(55);
    line(0, sw/10+20, sw, sw/10+20);  
    
    // Lat/Lon
    textFont(androidFont);
    fill(latColor);
    text("LAT ", sw/10, sh/10+(sh/16));
    fill(lonColor);
    text("LON ", sw/10, sh/10+((sh/16)*2));
    
    //text(foo, width/2, height/2+50);
    
    GPS();
    
    // Text Field
    stroke(200);
    fill(200);
    text("TAG", sw/2-(sw/12), sh/2+sh/16);
    container.show();
   
    // Buttons
    mRecordButton.recOn();
    mPlayButton.playOn();
    mStopButton.stopOn();
    mRecordButton.display();
    mPlayButton.display();
    mStopButton.display();
    
    // Menu Ellipses
    color S1Color = color(200);
    color S2Color = color(100);
    color S3Color = color(100);
    fill(S1Color);
    ellipse(sw/4, 9*(sh/10), sh/20, sh/20);
    fill(S2Color);
    ellipse(sw/2, 9*(sh/10), sh/20, sh/20);
    fill(S3Color);
    ellipse(3*(sw/4), 9*(sh/10), sh/20, sh/20);
    
    if(mousePressed) {
      
      if(mouseY > 8*(sh/10)) {
        if(mouseX > ((sw/2)-sh/10) && mouseX < ((sw/2)+sh/10) ) {
          gNotificationManager.notify(1, gNotification);
          displayState = 2;  
        }
        else if(mouseX > (3*(sw/4)-sh/10) && mouseX < (3*(sw/4)+sh/10) ) {
          gNotificationManager.notify(1, gNotification);
          displayState = 3;           
        }
      }    
      
    }
    
  }
}

//-----------------------------------------------------------------------------------------
// State 2 : Map

void State2() {
  if(displayState == 2) {
    background(10);
    container.hide();
    image(mapImage, 0, 0, width, height);
    
    // Menu Ellipses
    color S1Color = color(100);
    color S2Color = color(200);
    color S3Color = color(100);
    fill(S1Color);
    ellipse(sw/4, 9*(sh/10), sh/20, sh/20);
    fill(S2Color);
    ellipse(sw/2, 9*(sh/10), sh/20, sh/20);
    fill(S3Color);
    ellipse(3*(sw/4), 9*(sh/10), sh/20, sh/20);
    
    if(mousePressed) {
      if(mouseY > 8*(sh/10)) {
        if(mouseX > ((sw/4)-sh/10) && mouseX < ((sw/4)+sh/10) ) {
          gNotificationManager.notify(1, gNotification);
          displayState = 1;  
        }
        else if(mouseX > (3*(sw/4)-sh/10) && mouseX < (3*(sw/4)+sh/10) ) {
          gNotificationManager.notify(1, gNotification);
          displayState = 3;           
        }
      }
    }
    
  }
  
}


//-----------------------------------------------------------------------------------------
// State 3 : ReadMe

void State3() {
  if(displayState == 3) {
    background(10);
    container.hide();

    try{
      String readme[] = loadStrings("//sdcard//SonicDrift//README.txt");
      fill(255);
      textFont(smallFont); 
      textAlign(CENTER);
      rectMode(CORNER);     
      for(int i = 0; i < readme.length; i++) {
        String[] foo = splitTokens(readme[i],"\r");
        for(int j = 0; j < foo.length; j++) {
          text(readme[i], 20, 5+i*30, sw-40, 7*(sh/10));
        }
      }
    }
    catch(Exception noFile) {
      println("Exception Reading File... " + noFile); 
      //noFile.printStackTrace(); 
    }
    
    // Menu Ellipses
    color S1Color = color(100);
    color S2Color = color(100);
    color S3Color = color(200);
    fill(S1Color);
    ellipse(sw/4, 9*(sh/10), sh/20, sh/20);
    fill(S2Color);
    ellipse(sw/2, 9*(sh/10), sh/20, sh/20);
    fill(S3Color);
    ellipse(3*(sw/4), 9*(sh/10), sh/20, sh/20);
    
    if(mousePressed) {
      if(mouseY > 9*(sh/10)) {
        if(mouseX > ((sw/4)-sh/10) && mouseX < ((sw/4)+sh/10) ) {
          gNotificationManager.notify(1, gNotification);
          displayState = 1;  
        }
        else if(mouseX > ((sw/2)-sh/10) && mouseX < ((sw/2)+sh/10) ) {
          gNotificationManager.notify(1, gNotification);
          displayState = 2;           
        }
      }
    }
    
  }
}
