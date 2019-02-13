void unir() {
  int[] pos1 = punto();
  
  boolean point = false;
  
  for (int i=0; i<bodies.size (); i++) {
    SkeletonData _s = bodies.get(i);
    if (track(_s)) {
      point = det(_s, 11, pos1[1], pos1[2], 35); // Chequear que el numero corresponda a mano derecha
    }
  if (point) {
    println("Pintando!");
    for(int p = millis();p >= millis()-500;) {saveFrame("Jugadores/" + est +"/" + imagen + ".jpg");}
    pintar = true;
    background(back);
	ellipse(pos(_s, 11, 'x'),pos(_s, 11, 'y'),10,10); // Agregar circulos para dibujar
    time=millis();
    while(time >= millis()-5000){};
    return;
    }
  }
}

void poner() {
PVector posc;
time = millis();
	image(kinect.GetImage(), 0, 0, width, height);
	for (int i=0; i<bodies.size (); i++) {
		texto();
		SkeletonData _s = bodies.get(i);
		ellipse(pos(_s, 11, 'x'),pos(_s, 11, 'y'),10,10); //Agregar circulo para ubicar mano
		while (time <= millis()-5000  && _s.dwTrackingID == bod && time > 0) {
				posc = _s.skeletonPositions[11].copy();
			return;
		}
		log = new Log("/Textos/","imagen.txt",false, true);
		log.write(posc.x + ":" + posc.y);
		log.close();
	}
}