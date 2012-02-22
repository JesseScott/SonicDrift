//-----------------------------------------------------------------------------------------
// PLAYING

void onPlay(boolean start) {
  if (start) {
    if(playable) {
      startPlaying();
    }
  } 
  else {
    pausePlaying();
  }
}

void onStop() {

   stopPlaying(); 
  
  
}

void startPlaying() {
  println("Starting File...");
//  mPlayer = new MediaPlayer();
//  listener = new MyCompletionListener();
//  mPlayer.setOnCompletionListener(listener);
  
  if(!mPlayer.isPlaying()) {
    try {
      //playFileName = "far.mp3";
      playFileName = "sdcard/SonicDrift/" + playFileName;
      println("PLAYING " + playFileName);
      foo = "playing";
      mPlayer.setDataSource(playFileName);
      println("data set");
      //mPlayer.setDataSource("far.mp3");
      mPlayer.setLooping(false);
      mPlayer.setWakeMode(getApplicationContext(), PowerManager.PARTIAL_WAKE_LOCK);
      
      mPlayer.prepare();
      mPlayer.start();
      
    } 
    catch (IOException e) {
      //println("prepare() failed ... no match? ");
      //e.printStackTrace();
    }
  }
}

//public void setOnCompletionListener(OnCompletionListener mOnCompletionListener) {
//  mOnCompletionListener = listener;
//  onCompletion(mPlayer);
//  println("Listening...");
//}
//
//public void onCompletion(MediaPlayer mPlayer) {
//    //println("FINISHED...");
//    stopPlaying();
//}

void pausePlaying() {
  //println("Pausing...");
  //mPlayer.pause();   
}

void stopPlaying() {
  println("Stopping File...");
//  if(mPlayer != null) {
//    mPlayer.release();
//    mPlayer = null; 
//  }
}



