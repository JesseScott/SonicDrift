//-----------------------------------------------------------------------------------------
// GPS

public void GPS() {
  if(GPSactive == true) {
    
    //println("gps!!!");
    gpsColor = color(0, 155 + pulse, 0);
    fill(gpsColor);
    
    text("GPS   accurate to " + (int)currentAccuracy + " Metres", sw/10, sh/10+((sh/16)*3));
    
    fill(255);
    
    String Latitude = nf(currentLatitude, 2, 4);
    String LatH = Latitude.substring(0,2);
    String LatM = Latitude.substring(3,5);
    String LatS = Latitude.substring(5,7);
    
    text("  " + LatH + "." + LatM + LatS, sw/10*2, sh/10+(sh/16));

    String Longitude = nf(currentLongitude, 2, 4);
    String LonH = Longitude.substring(0,2);
    String LonM = Longitude.substring(3,5);
    String LonS = Longitude.substring(5,7);
  
    text("  " + LonH + "." + LonM + LonS, sw/10*2, sh/10+((sh/16)*2));
    
    ReadFile();

  } // gps active
}

