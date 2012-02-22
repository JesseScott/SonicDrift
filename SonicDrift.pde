/* 

This work is licensed under the Creative Commons Attribution-NonCommercial-Repurcusssions 3.0 Unported License. 
To view a copy of this license, visit http://www.graffitiresearchlab.fr/?portfolio=attribution-noncommercial-repercussions-3-0-unported-cc-by-nc-3-0

-- SonicDrift --
A Locative Audio Framework for Android OS

A project by the memelab
www.memelab.ca/sonic-drift

Developed as part of the MARIN 2011 Residency "Cartography and the Everyday at Sea"
www.marin.cc
With the assistance of
io/lab (Stavanger, Norway)
www.iolab.no
Kultivator (Oland, Sweden)
www.kultivator.org
Nida Art Colony (Nida, Lithuania)
www.colony.lt
 
Requires Sketch Permissions : ACCESS_COURSE_LOCATION, ACCESS_FINE_LOCATION, VIBRATE, WRITE_EXTERNAL_STORAGE, RECORD_AUDIO, WAKE_LOCK

Source Code was taken from examples by: 
Eric Pavey       ||  http://www.akeric.com/blog/?p=1334
Rolf Van Gelder  ||  http://cagewebdev.com/android/gps_example.zip
Algo Maccione    ||  http://madosedesoma.free.fr/
Hauke Altmann    ||  http://www.shine-in-decay.info/en
And various posts on the Processing Forum StackOverflow... 



*/

// IMPORTS
import android.content.Context;
import android.app.Activity;
import android.os.Bundle;
import android.os.Environment;

import android.app.Notification;
import android.app.NotificationManager;

import android.location.Location;
import android.location.LocationManager;
import android.location.LocationListener;
import android.location.GpsStatus.Listener;
import android.location.GpsStatus.NmeaListener;

import android.os.PowerManager;
import android.os.PowerManager.WakeLock;

import android.media.MediaRecorder;
import android.media.MediaPlayer;
import android.media.MediaPlayer.OnCompletionListener;

import java.io.File;
import java.io.IOException;

import apwidgets.*;
import android.text.InputType;
import android.view.inputmethod.EditorInfo;

// DECLARATIONS
APMediaPlayer far, near;

RecordButton mRecordButton = null;
PlayButton mPlayButton = null;
StopButton mStopButton = null;
MediaRecorder mRecorder = null;
MediaPlayer mPlayer = null;

screenLock wake;

MyCompletionListener listener;

APWidgetContainer container; 
APEditText tagLocation;

NotificationManager gNotificationManager;  
Notification gNotification; 

LocationManager locationManager;
MyLocationListener locationListener;

String[] fontList;
PFont androidFont, largeFont, smallFont;
PImage mapImage;
String[] readme;

PrintWriter output;

// GLOBAL VARIABLES
float currentLatitude  = 0;
float currentLongitude = 0;
float currentAltitude = 0;
float currentBearing = 0;
float currentSpeed = 0;
float currentAccuracy  = 0;
String currentProvider = "";

boolean GPSactive = false;
boolean LatMatch = false;
boolean LonMatch = false;
boolean playing = false;
boolean playable = true; //////
boolean time = false;

int displayState = 1;
int sw, sh;
int pulse = 0;
int then = 0; int now = 0; int curr = 0;

color currentColor;
color gpsColor = color(255,0,0); 
color latColor = color(255,0,0);
color lonColor = color(255,0,0);
color S1Color = color(200);
color S2Color = color(100);
color S3Color = color(100);

long[] gVibrate = {0, 50, 0, 50, 0, 50};

String Latitude, LatH, LatM, LatS;
String Longitude, LonH, LonM, LonS;
String taggedLocation;
String item;
String dirName;
String recFileName = null;
String playFileName = null;
String foo = "foo";
 
//-----------------------------------------------------------------------------------------

void setup() {
  // Screen
  size(screenWidth, screenHeight);
  orientation(PORTRAIT);
  background(0);
  smooth();
  rectMode(CENTER);
  ellipseMode(CENTER);
  
  sw = screenWidth;
  sh = screenHeight;
  
  // Power
  wake = new screenLock(this);
  wake.Start();
  
  // Player + Listener
  mPlayer = new MediaPlayer();
  listener = new MyCompletionListener();
  mPlayer.setOnCompletionListener(listener);
  
  // Image
  mapImage = loadImage("mapImage.gif");
  
  // Text
  fontList = PFont.list();
  androidFont = createFont(fontList[4], sw/20, true); // 20
  //textFont(androidFont);
  largeFont = createFont(fontList[4], sw/12, true); // 40 
  //textFont(largeFont);
  smallFont = createFont(fontList[4], sw/30, true); // 10 
  //textFont(smallFont);

  // Textfield
  container = new APWidgetContainer(this);
  tagLocation = new APEditText(sw/2-(sw/4), sh/2-(sh/8), sw/2, sh/8); // 180, 160, 100, 50
  container.addWidget(tagLocation);
  tagLocation.setInputType(InputType.TYPE_CLASS_TEXT);
  tagLocation.setImeOptions(EditorInfo.IME_ACTION_DONE); //Enables a Done button
  tagLocation.setCloseImeOnDone(true); //close the IME when done is pressed
  
  // Buttons
  color buttonColor = color(100);
  color highlight = color(255);
  mRecordButton = new RecordButton(sw/4, 4*(sh/6), sh/10, buttonColor, highlight);
  mPlayButton = new PlayButton(sw/2, 4*(sh/6), sh/10, buttonColor, highlight);
  mStopButton = new StopButton(3*(sw/4), 4*(sh/6), sh/10, buttonColor, highlight);


  // Create Directory
  try{
    dirName = "//sdcard//SonicDrift";
    File newFile = new File(dirName);
    newFile.mkdirs();
    if(newFile.exists()) {
      println("Directory Exists...");
      if(newFile.isDirectory()) {
        println("isDirectory = true...");
      } else println("isDirectory = false...");
    } else {
      println("Directory Doesn't Exist...");
    }
  }
  catch(Exception e) {
    println("Exception creating folder... " + e); 
    e.printStackTrace();
  }
  
  // Read Text File
  try{
    String lines[] = loadStrings("//sdcard//SonicDrift//SavedLocations.txt");
      println("Existing Files...");
      for(int i = 0; i < lines.length; i++) {
        //println(lines[i]);  
      }
  }
  catch(Exception noFile) {
    println("Exception Reading File... " + noFile); 
    noFile.printStackTrace(); 
  }
  
  //Create APMedia Players
  far = new APMediaPlayer(this);
  near = new APMediaPlayer(this);

  // Set Files and Playback
  
  far.setMediaFile("far.mp3"); // Set the file
  far.setLooping(false); // Restart playback end reached
  far.setVolume(0.1, 0.1); // Set left and right volumes. Range is from 0.0 to 1.0
  near.setMediaFile("near.mp3"); // Set the file
  near.setLooping(false); // Restart playback end reached
  near.setVolume(0.1, 0.1); // Set left and right volumes. Range is from 0.0 to 1.0
  
  
}

//-----------------------------------------------------------------------------------------

void draw() {
  frameRate(30);
  background(10);
  curr = millis() / 1000;
  //println("Current time is " + curr + " Then is " + then + " Now is " + now + " " + time);
  
  strokeWeight(3);
  strokeJoin(ROUND);
  stroke(255);
  fill(200);

  // Display State
  if(displayState == 1) {
    State1(); 
  }
  else if(displayState == 2) {
    State2(); 
  }
  else if(displayState == 3) {
    State3(); 
  }
  //println("STATE IS " + displayState);

  
} // draw

//-----------------------------------------------------------------------------------------


