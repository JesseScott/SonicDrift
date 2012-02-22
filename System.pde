//-----------------------------------------------------------------------------------------

void onResume() {
  println("Entering Sketch...");  
  super.onResume();

  //GPS Sensor
  locationListener = new MyLocationListener();
  locationManager = (LocationManager)getSystemService(Context.LOCATION_SERVICE);
  locationManager.requestLocationUpdates(LocationManager.GPS_PROVIDER, 0, 0, locationListener);
  
  // Notification Manager
  gNotificationManager = (NotificationManager) getSystemService(Context.NOTIFICATION_SERVICE);
  gNotification = new Notification();
  gNotification.vibrate = gVibrate;
  
}

//---

public boolean surfaceTouchEvent(MotionEvent event) {
  return super.surfaceTouchEvent(event);
}

//---

public class screenLock {
  PowerManager pm;
  Context context;
  WakeLock wl;

  public screenLock(Context parent) {
    this.context = parent;
    pm =(PowerManager) parent.getSystemService(Context.POWER_SERVICE);
    wl = pm.newWakeLock(PowerManager.FULL_WAKE_LOCK, "My Tag");
  }

  public void Start() {
    wl.acquire();
  }

  public void Stop() {
    wl.release();
  }
}

//---

void onPause() {
  println("Exiting Sketch...");
  super.onPause();
  super.onStop();
  
  // Release the Recorder
  if (mRecorder != null) {
    mRecorder.release();
    mRecorder = null;
  }
  
  // Release the Media Player
  if(mPlayer != null) {
    mPlayer.release();
    mPlayer = null; 
  }
  
  // Release Power Manager
  wake.Stop();

  //Release the Players
  /*
  if(far != null) { 
    far.release();     
  }
  if(near != null) {
    near.release(); 
  }
  */

}

//---




