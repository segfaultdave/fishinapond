/********************************************************

Sounds from freesound.org 


********************************************************/

import ddf.minim.Minim;
import ddf.minim.AudioPlayer;
import java.io.*;
import rwmidi.*;
import wekaizing.*;
import weka.core.Instances;
import weka.classifiers.trees.ADTree;

// for midi piano
MidiInput input;
MidiOutput output;
int max_note = 76;
int min_note = 65;
int num_notes = max_note-min_note;
int notePlayed = (max_note+min_note)/2;

// music back end
Musician musician;			       // our ML learner musician
final int music_length = 10;	 // the max number of notes in music
int phase;					           // 0 <= phase <= 4
boolean player_voted;          // proceed only when player voted
int player_judgement;          // player's judgement of what's played

// for timing
float last_millis;

// for audio playing
Minim minim;
AudioPlayer[] notes_audio;
AudioPlayer lake_sound;

// for front end visuals
PImage background_image;
Water[] waters;
Star[] stars, reflected_stars;
Fish fish;




void setup() {
  size(1000, 650);
  noFill();

  // we start at phase 0
  musician = new Musician();
  phase = 0;
  player_voted = false;
  player_judgement = 0;
  last_millis = 0.0;

  // start audio utilities
  rwmidiInit();
  loadAudioFiles();

  // start front end visuals
  background_image = loadImage("background.png");
  fishInit();
  waterInit();

  // load hardcoded star positions
  starsInit();

  println("\n\n");

  // load a 1 case so we do not infinite loop
  loadInitialMusic();
}


void draw() {
  
  // show the visuals in the background
  draw_background();
  
  // show the fish
  fish.display();

  // show the stars and pulses of music being played
  draw_stars();

  // run the code for the backend
  phaseDecision();

}


/**
 * Draws the background with images
 */
void draw_background()
{

  // play ambient lake sound effect, make it loop
  if(!(lake_sound.isPlaying()))
  {
    lake_sound.rewind();
    lake_sound.play();
  }

  // set background oclor
  background(6, 21, 37);
  
  // draw all the water
  for(int i = 0; i < waters.length; i++)
  {
    waters[i].update();
    waters[i].display();
  }

  // draw the mountains and stars
  tint(255,255);
  image(background_image, 0, 0);
}

/**
 * draw the stars and make them pulse
 */
void draw_stars()
{
  // draw pulses for playing music
  for(int i = 0; i < stars.length; i++)
  {
    stars[i].update();
    stars[i].display();

    reflected_stars[i].update();
    reflected_stars[i].display();
  }
}