//-----------------------------------------------------------------------------------------

@Override
void onResume() {
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
    wl = null;
  }
}

//---

@Override
protected void onPause() {
  super.onPause();

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
  wake = null;
  
  // Release Location Listener
  locationManager.removeUpdates(locationListener); 
  locationManager = null;

}

//@Override
//protected void onStop() {
//        super.onStop();
//}


//---




