//-----------------------------------------------------------------------------------------
// BUTTON

class Button {
  int x, y;
  int size;
  color basecolor, highlightcolor;
  color currentcolor;
  boolean over = false;
  boolean pressed = false;   

  boolean overRect(int x, int y, int width, int height) {
    if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
      return true;
    } 
    else {
      return false;
    }
  }

  boolean overCircle(int x, int y, int diameter) {
    float disX = x - mouseX;
    float disY = y - mouseY;
    if(sqrt(sq(disX) + sq(disY)) < diameter/2 ) {
      return true;
    } 
    else {
      return false;
    }
  }

}

//-----------------------------------------------------------------------------------------
// CIRCLE BUTTON

class CircleButton extends Button { 
  CircleButton(int ix, int iy, int isize, color icolor, color ihighlight) {
    x = ix;
    y = iy;
    size = isize;
    basecolor = icolor;
    highlightcolor = ihighlight;
    currentcolor = basecolor;
  }

  boolean over() {
    if( overCircle(x, y, size) ) {
      over = true;
      return true;
    } 
    else {
      over = false;
      return false;
    }
  }

  void display() {
    stroke(255);
    fill(currentcolor);
    ellipse(x, y, size, size);
  }
}

//-----------------------------------------------------------------------------------------
// RECORD BUTTON

class RecordButton extends CircleButton {
  boolean mStartRecording = true;

  RecordButton(int ix, int iy, int isize, color icolor, color ihighlight) {
    super(ix, iy, isize, icolor, ihighlight);
  }

  boolean over() {
    if ( overCircle(x, y, size) ) {
      over = true;
      return true;
    } 
    else {
      over = false;
      return false;
    }
  }

  void recOn() {
    if (over() && mousePressed) {
      gNotificationManager.notify(1, gNotification);
      fill(255);
      onRecord(mStartRecording);
      mStartRecording = !mStartRecording;
    }
    if (mStartRecording) {
      currentcolor = basecolor;
    } 
    else {
      currentcolor = highlightcolor;
    }
  }

  void display() {
    super.display();
    fill(255,0,0);
    textFont(androidFont);
    textSize(sw/10);
    //text("RECORD", sw/2-(sw/10), 3*(sh/4)+sh/6);
    String s = "R";
    float textW = textWidth(s);
    float textH = textAscent() + textDescent();
    text(s, x-textW/2, y+textH/3);
  }
}

//-----------------------------------------------------------------------------------------
// PLAY BUTTON

class PlayButton extends CircleButton {
  boolean mStartPlaying = true;

  PlayButton(int ix, int iy, int isize, color icolor, color ihighlight) {
    super(ix, iy, isize, icolor, ihighlight);
  }

  boolean over() 
  {
    if ( overCircle(x, y, size) ) {
      over = true;
      return true;
    } 
    else {
      over = false;
      return false;
    }
  }

  void playOn() {
    if (over() && mousePressed) {

       
       //onPlay(mStartPlaying);
       if(playable) {
         fill(255);
         startPlaying();
         gNotificationManager.notify(1, gNotification);
       }
       //mStartPlaying = !mStartPlaying;

    }
    if (mStartPlaying) {
      currentcolor = basecolor;
       } 
    else {
      currentcolor = highlightcolor;
       }
  }


  void display() {
    super.display();
    fill(0);
    textFont(androidFont);
    textSize(sw/10);
    String s = "P";
    float textW = textWidth(s);
    float textH = textAscent() + textDescent();
    text(s, x-textW/2, y+textH/3);
  }
}

//-----------------------------------------------------------------------------------------
// STOP BUTTON

class StopButton extends CircleButton {
  boolean mStartPlaying = false;

  StopButton(int ix, int iy, int isize, color icolor, color ihighlight) {
    super(ix, iy, isize, icolor, ihighlight);
  }

  boolean over() 
  {
    if ( overCircle(x, y, size) ) {
      over = true;
      return true;
    } 
    else {
      over = false;
      return false;
    }
  }

  void stopOn() {
    if (over() && mousePressed) {

       fill(255);
       stopPlaying();
       gNotificationManager.notify(1, gNotification);
       //mStartPlaying = !mStartPlaying;

    }
    if (mStartPlaying) {
      currentcolor = basecolor;
       } 
    else {
      currentcolor = highlightcolor;
       }
  }


  void display() {
    super.display();
    fill(0);
    textFont(androidFont);
    textSize(sw/10);
    String s = "S";
    float textW = textWidth(s);
    float textH = textAscent() + textDescent();
    text(s, x-textW/2, y+textH/3);
  }
}


