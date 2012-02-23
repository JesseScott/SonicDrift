//-----------------------------------------------------------------------------------------
//LISTENER
import android.media.MediaPlayer.OnCompletionListener;

public class MyCompletionListener implements MediaPlayer.OnCompletionListener {
 // Resets MediaPlayer So It Doesn't Play Over + Over
 public void onCompletion(MediaPlayer mPlayer) {
    mPlayer.reset();
    //mPlayer = null; 
  }
}

