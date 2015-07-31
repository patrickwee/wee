import processing.video.*;
import ddf.minim.*;

Minim minim;
AudioPlayer player;
AudioPlayer music;

PImage img;
Capture cam;

PFont font;


PImage welcome1, welcome2, welcome3;
PImage mode1, mode2, mode3, mode4;
PImage next, nexthover;
PImage arcticmode, underwatermode, junglemode;
PImage pumba, olaf, sebastian;
PImage score, timeplay, freeplay;
PImage how;
PImage startnow, startnowhover;
PImage playagain, playagainhover, howyoudid;

PImage exit, exithover;

int time;
int now;

int points;
int screenWidth;
int screenHeight;

int timeleft;

int gametime=30;
int gamelimit=20;

color trackColor;
float trackR, trackG, trackB;

int maxColorDiff;

int topLeftX;
int topLeftY;
int botRightX;
int botRightY;
float rx, ry, rw, rh;
float scancenterpointx, scancenterpointy;
float targetcenterx, targetcentery;
boolean guessing;

boolean welcomescreen=true;
boolean settingscreen=false;
boolean modescreen=false;
boolean gamescreen=false;
boolean gameoverscreen=false;

int mode = 0;
int setting = 0;

void setup() {
  screenWidth=1280;
  screenHeight=720;
  size(screenWidth, screenHeight);
  background(0);
  cam = new Capture(this, width, height);
  cam.start();

  minim = new Minim(this);
  player = minim.loadFile("blop.mp3");

  

  trackColor = color(255, 255, 255);
  trackR = red(trackColor);
  trackG = green(trackColor);
  trackB = blue(trackColor);
  maxColorDiff = 40;


  topLeftX=width;
  topLeftY=height;

  botRightX=0;
  botRightY=0;


  rx=200;
  ry=200;
  rw=80;
  rh=80;
  //points=0;

  next=loadImage("next.png");
  nexthover=loadImage("nexthover.png");
  startnow=loadImage("startnow.png");
  startnowhover=loadImage("startnowhover.png");

  exit=loadImage("exit.png");
  exithover=loadImage("exithover.png");

  playagain=loadImage("playagain.png");
  playagainhover=loadImage("playagainhover.png");
  howyoudid=loadImage("howyoudid.png");



  pumba=loadImage("jungle.png");
  sebastian=loadImage("underwater.png");
  olaf=loadImage("arctic.png");


  font = loadFont("DKHobgoblin-90.vlw");
}






void draw() {
  //WELCOME SCREEN
  textFont(font, 90);
  if (welcomescreen==true) {
    background(255);
    //Welcome Screen Code
    welcome1=loadImage("wel1.png");
    image(welcome1, 0, 0, screenWidth, screenHeight);
    welcome2=loadImage("wel2t.png");
    image(welcome2, 454, 483, 400, 50);
    welcome3=loadImage("wel3t.png");

    //rect(454, 483, 400, 100);
    if (mouseX>454 && mouseX<854 && mouseY>483 && mouseY<583 && welcomescreen==true) {
      image(welcome3, 434, 468, 440, 70);
    }
  };

  //MODE SCREEN
  if (modescreen==true) {
    background(255);
    //Welcome Screen Code
    mode1=loadImage("mode1.png");
    image(mode1, 40, -30, 1200, 200);

    arcticmode=loadImage("arcticmode.png");
    underwatermode=loadImage("underwatermode.png");
    junglemode=loadImage("junglemode.png");
    image(junglemode, 40, 320, 373, 373);
    image(underwatermode, 453, 320, 373, 373);
    image(arcticmode, 866, 320, 373, 373);

    image(pumba, 80, 140, 290, 290);
    image(sebastian, 453, 120, 373, 373);
    image(olaf, 886, 120, 373, 373);

    if (setting==0) {
      noFill();
      strokeWeight(5);
      stroke(130, 105, 83);
      rect(40, 130, 390, 500);
    } else if (setting==1) { 
      noFill();
      strokeWeight(5);
      stroke(130, 105, 83);
      rect(440, 130, 390, 500);
    } else if (setting==2) {
      noFill();
      stroke(130, 105, 83);
      strokeWeight(5);
      rect(846, 130, 390, 500);
    }


    image(next, 900, 650, 300, 40);

    if (mouseX>900 && mouseX<1200 && mouseY>650 && mouseY<690) {
      image(nexthover, 900, 650, 300, 40);
    }
  };



  //SETTING SCREEN
  if (settingscreen==true) {
    background(255);
    //Welcome Screen Code
    how=loadImage("how.png");
    image(how, 40, -30, 1200, 200);

    score=loadImage("score.png");
    timeplay=loadImage("time.png");
    freeplay=loadImage("freeplay.png");
    image(freeplay, 40, 240, 373, 373);
    image(timeplay, 453, 240, 373, 373);
    image(score, 866, 240, 373, 373);

    if (mode==0) {
      noFill();
      strokeWeight(5);
      stroke(130, 105, 83);
      rect(40, 130, 390, 500);
    } else if (mode==1) { 
      noFill();
      strokeWeight(5);
      stroke(130, 105, 83);
      rect(440, 130, 390, 500);
    } else if (mode==2) {
      noFill();
      stroke(130, 105, 83);
      strokeWeight(5);
      rect(846, 130, 390, 500);
    }


    image(startnow, 485, 650, 300, 40);

    if (mouseX>440 && mouseX<830 && mouseY>650 && mouseY<690) {
      image(startnowhover, 485, 650, 300, 40);
    }
    //Setting  Screen
  };





  if (gamescreen==true) {


    //CAMERA TRACKING
    if (cam.available()) {
      cam.read(); 
      image(cam, 0, 0); 

      loadPixels();
      int counter = 0;

      for (int j = 0; j<cam.height; j++) {
        for (int i = 0; i<cam.width; i++) {
          color c = cam.pixels[counter];
          float r =red(c);
          float g = green(c);
          float b = blue(c);       
          float colorDiff = dist(r, g, b, trackR, trackG, trackB);

          if (colorDiff<maxColorDiff) {
            if (i<topLeftX) {
              topLeftX=i;
            }
            if (j<topLeftY) {
              topLeftY=j;
            }        
            if (i>botRightX) {
              botRightX=i;
            }
            if (j>botRightY) {
              botRightY=j;
            }
          } else {
            pixels[i] = color(0);
          }
          counter++;
        }
      }
      updatePixels();  //Make sure that pixels update, for good measure.

      //***********************
      //CONSTANT IN ALL MODES!
      //***********************

      //COLOR SELECTED FOR TRACKING
      fill(trackColor);
      noStroke();
      rect(10, 10, 50, 50);

      //POINT TRACKER


      //EXIT
      image(exit, 1220, 10, 50, 50);
      if (mouseX>1220 && mouseX<1270 && mouseY>10 && mouseY<60) {
        image(exithover, 1220, 10, 50, 50);
      }

      //TRACKING BOX
      //Box for Tracking
      noFill();
      stroke(0);
      strokeWeight(2);
      rect(topLeftX, topLeftY, botRightX-topLeftX, botRightY-topLeftY);
      noStroke();

      //Center Point of Tracking Box
      scancenterpointx=(topLeftX+botRightX)/2;
      scancenterpointy=(topLeftY+botRightY)/2;
      stroke(0);
      strokeWeight(50);
      point(scancenterpointx, scancenterpointy);
      noStroke();


      //TARGET COORDINATES
      targetcenterx=rx+(rw/2);
      targetcentery=ry+(rh/2);






      //GAME CENTER

      if ((targetcenterx-100)<=scancenterpointx && scancenterpointx<=(targetcenterx+100) && (targetcentery-100)<=scancenterpointy && scancenterpointy<=(targetcentery+100)) {
        rx=random(0, screenWidth-100);
        ry=random(0, screenHeight-100);
        rw=random(90, 110);
        rh=random(90, 110);
        image(img, rx, ry, rw, rh);
        points+=1;
        player.play();
        player.rewind();
      } else {
        image(img, rx, ry, rw, rh);
      }

      fill(255);
      //***********************
      //TIME TRACKING
      //***********************
      time =(millis()-now)/1000;
      timeleft=gametime-time;


      if (mode==0) {
        //TIME TRACKER
        textSize(90);
        text(str(time) + " Seconds", 10, 700);
        fill(255, 179, 71);
        textSize(90);
        textAlign(RIGHT);
        text(str(points)+" Points", 1270, 700); 
        textAlign(LEFT);
      }

      //TIME MODE 
      if (mode==1) {
        if (time>=gametime) {
          gamescreen=false;
          gameoverscreen=true;
          music.pause();
          //points=0;
        } else {
          //TIME TRACKER
          fill(255);
          textSize(90);
          text(str(timeleft) + " Seconds Left", 10, 700);
          fill(255, 179, 71);
          textSize(90);
          textAlign(RIGHT);
          text(str(points)+" Points", 1270, 700); 
          textAlign(LEFT);
        }
      }
      //SCORE MODE

      if (mode==2) {
        if (points>=gamelimit) {
          //points=0;
          gamescreen=false;
          gameoverscreen=true;
          music.pause();
        } else {
          //TIME TRACKER
          fill(255);
          textSize(90);
          text(str(time) + " Seconds", 10, 700);
          fill(255, 179, 71);
          textSize(90);
          textAlign(RIGHT);
          text(str(points)+"/20 Points", 1270, 700); 
          textAlign(LEFT);
        }
      }





      //OTHER BACK-END STUFF
      botRightY=0;
      topLeftY=height;
      botRightX=0;
      topLeftX=width;
    }
  }
  if (gameoverscreen==true) {
    background(255);
    image(howyoudid, 0, 0, 1280, 250);
    //Welcome Screen Code
    //rect(500, 500, 100, 100);
    image(playagain, 485, 650, 300, 40);

    if (mouseX>440 && mouseX<830 && mouseY>650 && mouseY<690) {
      image(playagainhover, 485, 650, 300, 40);
    }
    fill(179, 158, 181);
    textAlign(CENTER);
    if (mode==0) {
      text("Mode: FREEPLAY", 640, 300);
      text("Time Elapsed: "+str(time)+" Seconds", 640, 400);
      text("Points: "+str(points), 640, 500);
    } else if (mode==1) {
      text("Mode: TIME", 640, 300);
      text("Points: "+str(points), 640, 400);
    } else if (mode==2) {
      text("Mode: SCORE", 640, 300);
      text("Time Elapsed: "+str(time)+" Seconds", 640, 400);
    }
    textAlign(LEFT);
  }
}


void mousePressed() {
  trackColor = cam.get(mouseX, mouseY);
  trackR = red(trackColor);
  trackG = green(trackColor);
  trackB = blue(trackColor);

  //CODE FOR WELCOME SCREEN
  //welcome screen
  if (mouseX>390 && mouseX<890 && mouseY>300 && mouseY<620 && welcomescreen==true) {
    welcomescreen=false;
    modescreen=true;
  }

  //mode
  if (mouseX>900 && mouseX<1200 && mouseY>650 && mouseY<690 && modescreen==true) {
    modescreen=false;
    settingscreen=true;
  }

  //setting
  if (mouseX>485 && mouseX<785 && mouseY>650 && mouseY<690 && settingscreen==true) {
    points=0;
    settingscreen=false;
    gamescreen=true;
    now = millis();
    music.loop();
  }

  //game
  if (mouseX>1220 && mouseX<1270 && mouseY>10 && mouseY<60 && gamescreen==true) {
    music.pause();
    gamescreen=false;
    gameoverscreen=true;
  }

  //gameover
  if (mouseX>440 && mouseX<830 && mouseY>650 && mouseY<690 && gameoverscreen==true) {
    gameoverscreen=false;
    welcomescreen=true;
  }

  //MODE SCREEN
  if (modescreen==true) {
    if (mouseY>130 && mouseY<630) {
      if (mouseX>40 && mouseX<430) {
        img=loadImage("jungle.png");
        music = minim.loadFile("jungle.mp3");
        setting = 0;
      } else if (mouseX>440 && mouseX<830) {
        img=loadImage("underwater.png");
        music = minim.loadFile("underwater.mp3");
        setting = 1;
      } else if (mouseX>840 && mouseX<1230) {
        img=loadImage("arctic.png");
        music = minim.loadFile("arctic.mp3");
        setting = 2;
      }
    }
  }

  //SETTINGSCREEN
  if (settingscreen==true) {
    if (mouseY>130 && mouseY<630) {
      if (mouseX>40 && mouseX<430) {
        mode=0;
      } else if (mouseX>440 && mouseX<830) {
        mode=1;
      } else if (mouseX>890 && mouseX<1230) {
        mode=2;
      }
    }
  }
}

