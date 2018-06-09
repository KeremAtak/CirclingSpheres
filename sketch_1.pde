import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;
import moonlander.library.*;

Moonlander moonlander;
Minim minim;
AudioPlayer song;

PImage bg;
int CANVAS_WIDTH = 480;
int CANVAS_HEIGHT = 360;
float ASPECT_RATIO = (float)CANVAS_WIDTH/CANVAS_HEIGHT;

int camposx;
int camposy;
int camposz;

int SONG_SKIP_MILLISECONDS = 200000;
float angle = 0;
int constant = 250;
int val = 1;
int plots = 4;

int rotateM = 3;
int speedM = 5;

void settings() {
  // The P3D parameter enables accelerated 3D rendering.
  size(CANVAS_WIDTH, CANVAS_HEIGHT, P3D);
}
 
void setup() {
  frameRate(60);
  smooth();
  bg = loadImage("space480360.jpg");
  moonlander = Moonlander.initWithSoundtrack(this, "cetus.mp3", 128, 4);
  
  moonlander.start();  
  setupAudio();
}

void setupAudio() {
  minim = new Minim(this);
  song = minim.loadFile("cetus.mp3");
  // Uncomment this if you want the demo to start instantly
  //song.play();
}
 
void draw() {
  background(bg);
  moonlander.update();
  val = moonlander.getIntValue("test");
  int start = moonlander.getIntValue("start");
  camposx = moonlander.getIntValue("camposx");
  camposy = moonlander.getIntValue("camposy");
  camposz = moonlander.getIntValue("camposz");

  camera(camposx, camposy, camposz, width/2, height/2, 0, 0, 1, 0);
  rotateX(camposx / 100);
  rotateY(camposy / 100);
  if (start !=  -1) {
    drawDemo(5);
  }
}


void drawDemo(float time) {
  translate(width/2, height/2);
  //rotateZ(1);
  drawBall(0);
  drawBall(1.5);
  drawBall(3);
  drawBall(4.5);
}

void drawBall(float i) {
  float t = millis()/1000.0f;
  float x = 100 * sin( t + i ); 
  float y = 100 * cos( t + i );
  fill(100, 100, 100);
  pushMatrix();
  translate(x, y);
  rotate(t);
  sphere(30);
  popMatrix();
  angle += PI*2/plots;
}

//void keyPressed() {
  //if (key == CODED) {
    
    // Left/right arrow keys: seek song
    //if (keyCode == LEFT) {
    //  song.skip(-SONG_SKIP_MILLISECONDS);
    //} 
    //else if (keyCode == RIGHT) {
      //song.skip(SONG_SKIP_MILLISECONDS);
    //}
  //}
  // Space bar: play/payse
  //else if (key == '!') {
    //if (song.isPlaying())
      //song.pause();
    //else
      //song.play();
  //}
  // Enter: spit out the current position
  // (for syncing)
  //else if (key == ENTER) {
    //print(song.position() + ", ");
  //}
//}
