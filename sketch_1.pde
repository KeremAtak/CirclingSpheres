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

int ballsize;
int radius;
int timeranout;
int beat;

boolean plusColorX = false;
boolean plusColorY = false;
boolean plusColorZ = false;
boolean fastBump = false;

int colorX = 255;
int colorY = 255;
int colorZ = 255;

int SONG_SKIP_MILLISECONDS = 200000;
float angle = 0;
int constant = 250;
int val = 1;
int plots = 4;

int rotationSpeed = 5000;
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
  //nothing to see here..
  val = moonlander.getIntValue("test");
  int start = moonlander.getIntValue("start");
  camposx = moonlander.getIntValue("camposx");
  camposy = moonlander.getIntValue("camposy");
  camposz = moonlander.getIntValue("camposz");
  ballsize = moonlander.getIntValue("ballsize ");
  radius = moonlander.getIntValue("radius");
  timeranout = moonlander.getIntValue("timeranout");
  beat = moonlander.getIntValue("beat");
  
  if (beat == 1) {
   adjustBeat(); 
  }
  
  if (moonlander.getIntValue("color") == 1) {
    yswap(1);  
  } else if (moonlander.getIntValue("color") == 2) {
    xswap(5);
    yswap(4);
  } else if (moonlander.getIntValue("color") == 3) {
    xswap(2);
    yswap(3);
    zswap(5);
  } else if (moonlander.getIntValue("color") == 4) {
    xswap(7);
    yswap(5);
    zswap(3);
  } else if (moonlander.getIntValue("color") == 5) {
    xswap(13);
    yswap(11);
    zswap(9);
  } else if (moonlander.getIntValue("color") == 6) {
    xswap(21);
    yswap(31);
    zswap(29);
  }
  
  
  if (moonlander.getIntValue("speed") == 1) {
    fastBump = true; 
  } else if (moonlander.getIntValue("speed") == 2) {
    if (fastBump) {
      speedTo(30000, 1000);
    }
    fastBump = false;
  } else if (moonlander.getIntValue("speed") == 3) {
    if (fastBump) {
      speedTo(40000, 2000);
    }
    fastBump = false;
  } else if (moonlander.getIntValue("speed") == 4) {
    if (fastBump) {
      speedTo(50000, 3000);
    }
    fastBump = false;
  } else if (moonlander.getIntValue("speed") == 5) {
    if (fastBump) {
      speedTo(100000, 5000);
    }
    fastBump = false;
  } else if (moonlander.getIntValue("speed") == 7) {
    rotationSpeed = 150000;
  } else if (moonlander.getIntValue("speed") == 8) {
    rotationSpeed = 50000;
  } else if (moonlander.getIntValue("speed") == 6) {
    speedTo(50000, -5000);
    fastBump = false;
  }
  else if (moonlander.getIntValue("speed") == 0) {
    rotationSpeed = 5001;
  }
  

  camera(camposx, camposy, camposz, width/2, height/2, 0, 0, 1, 0);
  //rotateX(camposx / 100);
  //rotateY(camposy / 100);
  if (start !=  -1) {
    drawDemo(5);
  }
}

void adjustBeat() {
  
}

void speedTo(int speed, int i) {
  if (rotationSpeed + i <= speed) {
    rotationSpeed += i;
  }
}

//changes colors
void xswap(int speed) {
  //println("X ",colorX);
  if(plusColorX){
    if (colorX + speed > 255) {
      plusColorX = false;
    } else {
      colorX += speed;
    }
  } else {
    if (colorX - speed < 0) {
      plusColorX = true;
    } else {
      colorX -= speed;
    }
  }
}

//please ignore copypaste
void yswap(int speed) {
  //println("Y ",colorY);
  if(plusColorY){
    if (colorY + speed > 255) {
      plusColorY = false;
    } else {
      colorY += speed;
    }
  } else {
    if (colorY - speed < 0) {
      plusColorY = true;
    } else {
      colorY -= speed;
    }
  }
}

void zswap(int speed) {
  //println("Z ",colorZ);
  if(plusColorZ){
    if (colorZ + speed > 255) {
      plusColorZ = false;
    } else {
      colorZ += speed;
    }
  } else {
    if (colorZ - speed < 0) {
      plusColorZ = true;
    } else {
      colorZ -= speed;
    }
  }
}

void dividableWith(int number)  {
  while (colorX % number != 0) {
    colorX--;
  }
  while (colorY % number != 0) {
    colorY--;
  }
  while (colorZ % number != 0) {
    colorZ--;
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
  float t = millis()/(1000.0f / (1.0 * rotationSpeed / 10000));
  println( rotationSpeed);
  float x = 100 * sin( t + i ); 
  float y = 100 * cos( t + i );
  fill(colorX, colorY, colorZ);
  pushMatrix();
  translate(x * (1.0 * radius / 10), y * (1.0 * radius / 10));
  rotate(t);
  if (timeranout != 1) {
      sphere(ballsize);
  } else {
    text("Aika loppui ':D'",50,50);
  }
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
