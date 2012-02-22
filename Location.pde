//-----------------------------------------------------------------------------------------
// LocationListener

class MyLocationListener implements LocationListener {
   void onLocationChanged(Location location) {
      // Turn Boolean True once GPS has fix
      GPSactive = true;
      // Called when a new location is found by the network location provider.
      currentLatitude  = (float)location.getLatitude();
      currentLongitude = (float)location.getLongitude();
      currentAltitude = (float)location.getAltitude();
      currentBearing = (float)location.getBearing();
      currentSpeed = (float)location.getSpeed();
      currentAccuracy  = (float)location.getAccuracy();
      currentProvider  = location.getProvider();
    }
    void onProviderDisabled (String provider) { 
      currentProvider = "";
    }

    void onProviderEnabled (String provider) { 
      currentProvider = provider;
    }

    void onStatusChanged (String provider, int status, Bundle extras) {
      // Nothing yet...
      //println("New Status...");
    }
    
}
