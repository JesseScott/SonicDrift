//-----------------------------------------------------------------------------------------
// SAVING LOCATION

void saveToFile() {
  if(Latitude != null && Longitude != null) {
    taggedLocation = tagLocation.getText() + ".3gp";
    try {
      BufferedWriter writer = new BufferedWriter(new FileWriter("//sdcard//SonicDrift//SavedLocations.txt", true));
      writer.write(taggedLocation);
      writer.write("\n");
      writer.write(Latitude);
      writer.write("\n");
      writer.write(Longitude);
      writer.write("\n");
      writer.flush();
      writer.close();
    } 
    catch (IOException e) {
      e.printStackTrace();
    }
  }
}

