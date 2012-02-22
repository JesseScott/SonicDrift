//-----------------------------------------------------------------------------------------
//RECORDING

void onRecord(boolean start) {
  if (start) {
    startRecording();
  } 
  else {
    stopRecording();
  }
}

void startRecording() {
  //println("Starting Recording...");
  
  // Set Directory
  recFileName = Environment.getExternalStorageDirectory().getAbsolutePath();
  recFileName += "/SonicDrift/" + tagLocation.getText() + ".3gp";
  
  mRecorder = new MediaRecorder();
  mRecorder.setAudioSource(MediaRecorder.AudioSource.MIC);
  mRecorder.setOutputFormat(MediaRecorder.OutputFormat.THREE_GPP);
  mRecorder.setAudioEncoder(MediaRecorder.AudioEncoder.AMR_NB);
  mRecorder.setOutputFile(recFileName);

  try {
    mRecorder.prepare();
  } 
  catch (IOException e) {
    println("Prepare() Failed...");
    //e.printStackTrace();
  }

  mRecorder.start();
  //println("(Really Starting Recording...)");

}

void stopRecording() {
  //println("Stopping Recording...");
  saveToFile();
  mRecorder.stop();
  mRecorder.release();
  mRecorder = null;
}
