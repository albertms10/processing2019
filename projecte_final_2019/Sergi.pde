


class Sergi extends Animacio {
  int radi1, radi2,roda1, roda2, roda3, i, slider3;

  BeatDetect beat = new BeatDetect(song.bufferSize(), song.sampleRate());
  int x;
  int y;
  float outsideRadius=1;
  float insideRadius=1;
  
  Sergi(String songName) {
    super(songName);
    init();
    song.play();
  }

  /**
   * Mètode equivalent al setup()
   */
  void init() {
   ellipseMode(RADIUS);
  radi1 = slider[1];
  radi2 = slider[2];
  roda1 = knob[1]*5;
  roda2 = knob[2]*5;
  roda3 = knob[3]*7;
  slider3 = slider[3]*8;
  x = width/2;
  y = height/2;
  }

  /**
   * Mètode per a càlculs, si cal
   */
  void run() {}

  /**
   * Mètode equivalent al draw()
   */
  void display() {
    i=1;
   radi1 = slider[1];
   radi2 = slider[2];
   roda1 = knob[1]*3;
   roda2 = knob[2]*5;
   roda3 = knob[3]*7;
   slider3 = slider[3]*8;
   int numPoints = int(map(roda1, 0, width, 6, 60));
   float angle=0;
   float angleStep = 180.0/numPoints;
   background(roda1,roda2,roda3);
    fill(HSB, 255,255,255);
   ellipse(width/2, height/2, radi1*2, radi1*2);
  
  //for (int i = 0; i < 200; i += 20) {
  //  noFill();
    //bezier(song.left.get(i), roda3, song.left.get(i),roda3, roda3, roda3, width/2, height/2);
  //}
    beginShape(TRIANGLE_STRIP); 
  for (int i = 0; i <= numPoints; i++) {
    float px = x + cos(radians(angle)) * outsideRadius*radi1*2;
    float py = y + sin(radians(angle)) * outsideRadius*radi1*2;
    angle += angleStep;
    vertex(px, py);
    px = x + cos(radians(angle)) * insideRadius*radi2;
    py = y + sin(radians(angle)) * insideRadius*radi2;
    vertex(px, py); 
    angle += angleStep;
  }
  endShape();
  
  // if(frameCount%10==0){
   //fill(HSB, 120,100,160);
   //ellipse(random(width), height/2, song.left.get(i)*100*radi2, song.right.get(i)*100*radi2);
   //}
  }
  
  /**
   * Aquestes funcions (potser no calen totes)
   * les haurem de programar com si fossin les funcions de teclat i ratolí.
   * Les cridem des del programa principal quan la nostra animació està activa.
   */
   
   
  void f_keyPressed() {}
  
  void f_keyReleased() {}

  void f_mousePressed() {}

  void f_mouseDragged() {}

  void f_mouseReleased() {}
  
}
