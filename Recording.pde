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
  // Set Directory
  recFileName = Environment.getExternalStorageDirectory().getAbsolutePath();
  recFileName += "/SonicDrift/" + tagLocation.getText() + ".3gp";
  // Set MediaRecorder
  mRecorder = new MediaRecorder();
  mRecorder.setAudioSource(MediaRecorder.AudioSource.MIC);
  mRecorder.setOutputFormat(MediaRecorder.OutputFormat.THREE_GPP);
  mRecorder.setAudioEncoder(MediaRecorder.AudioEncoder.AMR_NB);
  mRecorder.setOutputFile(recFileName);
  try {
    mRecorder.prepare();
  } 
  catch (IOException e) {
    //e.printStackTrace();
  }
  mRecorder.start();
}

void stopRecording() {
  saveToFile();
  mRecorder.stop();
  mRecorder.release();
  mRecorder = null;
}
