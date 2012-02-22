//-----------------------------------------------------------------------------------------
//LISTENER
import android.media.MediaPlayer.OnCompletionListener;

public class MyCompletionListener implements MediaPlayer.OnCompletionListener {

// protected MediaPlayer player;
//
// public void setPlayer(MediaPlayer player){
//       this.player = player;
// }

 public void onCompletion(MediaPlayer mPlayer) {
    println("CALLING...");
    foo = "completing";
    mPlayer.reset();
    //mPlayer = null; 
  }
}

