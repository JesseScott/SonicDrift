//-----------------------------------------------------------------------------------------
// READFILE

void ReadFile() {  
  try {
    String lines[] = loadStrings("/sdcard/SonicDrift/SavedLocations.txt");
      // Lat
      for(int i = 1; i < lines.length; i += 3) { 
        if(lines[i].equals(Latitude) && lines[i+1].equals(Longitude)) {
          LatMatch = true;
          latColor = color(0,255,0);
          LonMatch = true;
          lonColor = color(0,255,0);
          item = lines[i-1];  // assign variable 
          break;
        }
        else if(lines[i].equals(Latitude) && lines[i+1].equals(Longitude) == false || lines[i].equals(Latitude) == false && lines[i+1].equals(Longitude)) {
//          if(frameCount % 500 == 50) {
//            far.seekTo(0);
//            far.start(); 
//          }
        }
        else { 
          LatMatch = false;
          LonMatch = false;  
          lonColor = color(255,0,0); 
          latColor = color(255,0,0);
        }
        
      }// for
      
      // Match!!
      if( LatMatch == true && LonMatch == true) {
        playable = true;
        playFileName = item;  // First line of three   
        // Call Play() function
        startPlaying();
        fill(gpsColor);
        String trimmed[] = split(item, '.'); // trim off the file extension
        text(trimmed[0], sw/10, sh/10+((sh/16)*4));                    
      } // true
  } // try
  catch(Exception noFile) {
    //println("Exception Reading File... " + noFile); 
    //noFile.printStackTrace(); 
  } // catch
} // void
