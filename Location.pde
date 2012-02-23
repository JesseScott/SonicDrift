//-----------------------------------------------------------------------------------------
// LocationListener

class MyLocationListener implements LocationListener {
   void onLocationChanged(Location location) {
     if(location != null) {
       // Turn Boolean True Once GPS Has Fix
       GPSactive = true;
       // Called When A New Location Is Found By The Provider
       currentLatitude  = (float)location.getLatitude();
       currentLongitude = (float)location.getLongitude();
       currentAccuracy  = (float)location.getAccuracy();
       currentProvider  = location.getProvider();
     }
   }
    
    void onProviderDisabled (String provider) { 
      currentProvider = "";
    }

    void onProviderEnabled (String provider) { 
      currentProvider = provider;
    }

    void onStatusChanged (String provider, int status, Bundle extras) {

    }
    
}
