//-----------------------------------------------------------------------------------------
// GPS

public void GPS() {
  if(GPSactive == true) {
    // Pulse + Show Accuracy
    gpsColor = color(0, 155 + pulse, 0);
    fill(gpsColor);
    textFont(androidFont);
    text("GPS   accurate to " + (int)currentAccuracy + " Metres", sw/10, sh/10+((sh/16)*3));
    
    // Show Lat + Lon To Current Resolution   
    fill(200);
    Latitude = nf(currentLatitude, 4, GPSres);
    text("  " + Latitude, sw/10*2, sh/10+(sh/16));
    Longitude = nf(currentLongitude, 4, GPSres); 
    text("  " + Longitude, sw/10*2, sh/10+((sh/16)*2));
    
    // Read From File To Match GPS
    ReadFile();

  } // gps active
}

