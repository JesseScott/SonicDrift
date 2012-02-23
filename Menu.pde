//-----------------------------------------------------------------------------------------
// State 1 : ABOUT

void State1() {
  if(displayState == 1) {   
    background(bg);
    texfieldContainer.hide();
    radioContainer.hide();
    image(about, 0, 0, width, height);
    if(mousePressed) displayState = 2;
  }
}

//-----------------------------------------------------------------------------------------
// State 2 : INSTRUCTIONS

void State2() {
  if(displayState == 2) {
    background(bg);
    texfieldContainer.hide();
    radioContainer.hide();
    image(instructions, 0, 0, width, height);   
    if(mousePressed) displayState = 3;
  }
}


//-----------------------------------------------------------------------------------------
// State 3 : MAIN

void State3() {
  if(displayState == 3) {
    background(bg);
    strokeWeight(3);
    strokeJoin(ROUND);
    textAlign(LEFT); 
    
    // Pulse For Text
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
    
    stroke(200);
    fill(200);
    
    //Resolution Buttons
    text("SET GPS RESOLUTION ", sw/8, sh/2 -10);
    radioContainer.show();
    if(res3.isChecked()){
      GPSres = 3;
    }else if(res4.isChecked()){
      GPSres = 4;
    }else if(res5.isChecked()){
      GPSres = 5;
    }
    
    // Call GPS Function
    GPS();
    
    // Text Field
    text("NAME FILE ", sw/8, 3*(sh/4) -10);
    texfieldContainer.show();
   
    // Record Button
    //mRecordButton.recOn();
    //mRecordButton.display();
  }
}
