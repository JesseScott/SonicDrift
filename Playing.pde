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
  if(!mPlayer.isPlaying()) {
    try {
      playFileName = "sdcard/SonicDrift/" + playFileName;
      mPlayer.setDataSource(playFileName);
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

void pausePlaying() {
  //mPlayer.pause();   
}

void stopPlaying() {
//  if(mPlayer != null) {
//    mPlayer.release();
//    mPlayer = null; 
//  }
}



