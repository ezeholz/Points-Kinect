void unir() {
  int[] pos1 = punto();
  
  boolean point = false;
  
  for (int i=0; i<bodies.size (); i++) {
    SkeletonData _s = bodies.get(i);
    if (track(_s)) {
      point = det(_s, pos1[0], pos1[1], pos1[2], 35);
    }
  if (point) {fill(0,255,0,180);} else {fill(255,0,0,180);} ellipse(pos1[1], pos1[2], 35, 35);
  if (point) {
    println("Pintando!");
    for(int p = millis();p >= millis()-500;) {saveFrame("Jugadores/" + est +"/" + imagen + ".jpg");}
    pintar = true;
    background(back);
    time=millis();
    while(time >= millis()-5000){};
    return;
    }
  }
}