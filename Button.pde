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
    stroke(200);
    fill(200);
    textFont(androidFont);
    String s = "REC FILE ";
    float textW = textWidth(s);
    float textH = textAscent() + textDescent();
    text(s, x-textW/2, 3*(sh/4) -10);
    noFill();
    rect(x, y, sh/8, sh/8);
  }
}

//-----------------------------------------------------------------------------------------

