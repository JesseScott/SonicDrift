/* 

This work is licensed under the Creative Commons Attribution-NonCommercial-Repurcusssions 3.0 Unported License. 
To view a copy of this license, visit http://www.graffitiresearchlab.fr/?portfolio=attribution-noncommercial-repercussions-3-0-unported-cc-by-nc-3-0

-- SonicDrift --
A Locative Audio Framework for Android OS

A project by the memelab
www.memelab.ca/sonic-drift
Written by Jesse Scott

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

Eric Pavey       ||  http://www.akeric.com
Rolf Van Gelder  ||  http://cagewebdev.com
Algo Maccione    ||  http://madosedesoma.free.fr
Hauke Altmann    ||  http://www.shine-in-decay.info/en

And various posts on the Processing Forum StackOverflow... thanks open source community!



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

RecordButton mRecordButton;
MediaRecorder mRecorder;
MediaPlayer mPlayer;

screenLock wake;

MyCompletionListener listener;

APWidgetContainer texfieldContainer; 
APWidgetContainer radioContainer; 
APRadioButton res3;
APRadioButton res4;
APRadioButton res5;
APRadioGroup radioGroup;
APEditText tagLocation;

NotificationManager gNotificationManager;  
Notification gNotification; 

LocationManager locationManager;
MyLocationListener locationListener;

String[] fontList;
PFont androidFont, largeFont, smallFont;
PImage about, instructions;
PrintWriter output;

// GLOBAL VARIABLES

float currentLatitude  = 0;
float currentLongitude = 0;
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
int GPSres = 4;

color currentColor;
color bg = #231F20;
color gpsColor = color(255,0,0); 
color latColor = color(255,0,0);
color lonColor = color(255,0,0);
color S1Color = color(200);
color S2Color = color(100);
color S3Color = color(100);

long[] gVibrate = {0, 50, 0, 50, 0, 50};

String Latitude;
String Longitude;
String taggedLocation;
String item;
String dirName;
String recFileName;
String playFileName;
 
//-----------------------------------------------------------------------------------------

void setup() {
  // Screen
  size(screenWidth, screenHeight); // 480 x 800 on N1
  orientation(PORTRAIT);
  background(bg);
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
  about = loadImage("about.png");
  instructions = loadImage("instructions.png");
  
  // Text
  fontList = PFont.list();
  androidFont = createFont(fontList[4], sw/20, true); // 20
  largeFont = createFont(fontList[4], sw/12, true); // 40 
  smallFont = createFont(fontList[4], sw/30, true); // 10 

  // Textfield
  texfieldContainer = new APWidgetContainer(this);
  tagLocation = new APEditText(sw/8, 3*(sh/4), sw/2, sh/8); // 60, 600, 200, 100
  texfieldContainer.addWidget(tagLocation);
  tagLocation.setInputType(InputType.TYPE_CLASS_TEXT);
  tagLocation.setImeOptions(EditorInfo.IME_ACTION_DONE); 
  tagLocation.setCloseImeOnDone(true); 
  texfieldContainer.hide();
  
  // Radio Group
  radioContainer = new APWidgetContainer(this); 
  radioGroup = new APRadioGroup(sw/8, sh/2);
  radioGroup.setOrientation(APRadioGroup.HORIZONTAL);
  
  res3 = new APRadioButton("3 PT  ");
  res4 = new APRadioButton("4 PT "); 
  res5 = new APRadioButton("5 PT "); 
  
  radioGroup.addRadioButton(res3); 
  radioGroup.addRadioButton(res4); 
  radioGroup.addRadioButton(res5); 
  res4.setChecked(true); 
  radioContainer.addWidget(radioGroup);
  
  // Buttons
  color buttonColor = color(100);
  color highlight = color(255);
  mRecordButton = new RecordButton(3*(sw/4), 3*(sh/4) + sh/16, sh/8, buttonColor, highlight);

  // Create Directory
  try{
    dirName = "//sdcard//SonicDrift";
    File newFile = new File(dirName);
    newFile.mkdirs();
    if(newFile.exists()) {
      //println("Directory Exists...");
      if(newFile.isDirectory()) {
        //println("isDirectory = true...");
      } else println("isDirectory = false...");
    } else {
      //println("Directory Doesn't Exist...");
    }
  }
  catch(Exception e) {

  }
  
  // Read Text File
  try{
    String lines[] = loadStrings("//sdcard//SonicDrift//SavedLocations.txt");
      //println("Existing Files...");
      for(int i = 0; i < lines.length; i++) {
        //println(lines[i]);  
      }
  }
  catch(Exception noFile) {
    //noFile.printStackTrace(); 
  }
  
  
}

//-----------------------------------------------------------------------------------------

void draw() {
  frameRate(30);
  background(10);
  curr = millis() / 1000;
  
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
  
} // draw

//-----------------------------------------------------------------------------------------


