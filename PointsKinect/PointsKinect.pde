/*
#    Proyecto con la Kinect
#          Puerta 18
#
#    Ezequiel G. Holzweissig
#    
#  190 cm
#
#    www.puerta18.org.ar
*/

import processing.opengl.*;
import kinect4WinSDK.Kinect;
import kinect4WinSDK.SkeletonData;
ArrayList <SkeletonData> bodies;

PImage back;

Kinect kinect;
Log log;

boolean test = true;

int time = 0, bod = 0, est = 0;
int imagen = 0;
boolean pintar = true;

void settings() {
    //size(1024, 768, OPENGL);
    fullScreen(OPENGL, 2);
}

void setup() {
  kinect = new Kinect(this);
  log= new Log("/Posiciones/","Poses.txt",false, false);
  smooth(3);
  bodies = new ArrayList<SkeletonData>();
  
  ellipseMode(RADIUS);
  
  back = bg("/Posiciones/posini.jpg");
  background(back);
  
  est = hour()*10000 + minute()*100 + second();
  
  thread("randomizer");
}

void draw() {
  if(pintar){
    background(back);
    tint(255, 220);
    image(kinect.GetMask(), 0, 0, width, height);
  }
  if(test) {poner();}else {unir();}
}

PImage bg(String a) {
  PImage rta = loadImage(a);
  rta.resize(width,height);
  return rta;
}

void appearEvent(SkeletonData _s) 
{if (bod == 0){
  if (_s.trackingState == Kinect.NUI_SKELETON_NOT_TRACKED) 
  {
    return;
  }
  synchronized(bodies) {
    bodies.add(_s);
    bod = _s.dwTrackingID;
  }
}}

void disappearEvent(SkeletonData _s) 
{if (bod != 0){
  synchronized(bodies) {
    for (int i=bodies.size ()-1; i>=0; i--) 
    {
      if (_s.dwTrackingID == bodies.get(i).dwTrackingID || 0 == bodies.get(i).dwTrackingID) 
      {
        bodies.remove(i);
        bod = 0;
      }
    }
  }
}}

void moveEvent(SkeletonData _b, SkeletonData _a)
{
  if (_a.trackingState == Kinect.NUI_SKELETON_NOT_TRACKED) 
  {
    return;
  }
  synchronized(bodies) {
    for (int i=bodies.size ()-1; i>=0; i--) 
    {
      if (_b.dwTrackingID == bodies.get(i).dwTrackingID) 
      {
        bodies.get(i).copy(_a);
        break;
      }
    }
  }
}

boolean track(SkeletonData _s) {
  int b = Kinect.NUI_SKELETON_POSITION_HEAD;
  if (_s.skeletonPositionTrackingState[b] != Kinect.NUI_SKELETON_POSITION_NOT_TRACKED) {return true;} else {return false;}
}

float pos(SkeletonData _s, int b, char c) {
  //a = "Kinect.NUI_SKELETON_POSITION_" + a;
  //int b = a.substring(0);
  if (c == 'x') {return _s.skeletonPositions[b].x*width;}
  if (c == 'y') {return _s.skeletonPositions[b].y*height;}
  if (c == 'z') {return _s.skeletonPositions[b].z*-8000;}
  else return Kinect.NUI_SKELETON_POSITION_NOT_TRACKED;
}

boolean det(SkeletonData _s, int s, int x, int y, int d) {
  if (pos(_s, s, 'x') >= x-d && pos(_s, s, 'x') <= x+d) {
        if (pos(_s, s, 'y') >= y-d && pos(_s, s, 'y') <= y+d) {
          return true;
        } else {return false;}
      } else {return false;}
}

void keyPressed() {
  if (key=='*') {
    est = hour()*10000 + minute()*100 + second();
  }
  if (key=='/'){
    imagen=0;
    thread("randomizer");
    time=0;
    back = bg("/Posiciones/posini.jpg");
  }
}

int[] punto() {
  String[] file = loadStrings(sketchPath()+"/Imagenes/Imagen" +imagen+ ".txt");
  String[] file2=new String[2];
  int[] rta=new int[2];
  float[] floats=new float[3];
  for (int i=0; i < file.length; i++) {
    if (file[0] != file[i]){
      file[0] = file[0] + file[i];
    }
  }
  file2=split(file[0],":");
  for (int i=0;i<file2.length;i++) {
      floats[i] = float(file2[i]);
  }
  for (int i=0;i<floats.length;i++) {
    switch(i){
    case 0:rta[i] = int(floats[i]*width);break;
    case 1:rta[i] = int(floats[i]*height);break;
    }
  }
  return rta;
}

void randomizer() {
  randomSeed(hour()*10000+minute()*100+second());
  int id=log.id;
  int round = (int)random(id);
  imagen = round;
}