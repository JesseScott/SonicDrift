//-----------------------------------------------------------------------------------------
// SAVING LOCATION

void saveToFile() {
  //println("Saving GPS");
  String taggedLocation = tagLocation.getText() + ".3gp";
  String currLat = nf(currentLatitude, 2, 4);
  String currLon = nf(currentLongitude, 2, 4);

  try {
    BufferedWriter writer = new BufferedWriter(new FileWriter("//sdcard//SonicDrift//SavedLocations.txt", true));
    writer.write(taggedLocation);
    writer.write("\n");
    writer.write(currLat);
    writer.write("\n");
    writer.write(currLon);
    writer.write("\n");
    writer.flush();
    writer.close();
  } 
  catch (IOException e) {
    //println("Saving Error... " + e);

  }
}

