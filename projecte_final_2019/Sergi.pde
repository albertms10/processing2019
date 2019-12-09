class Sergi extends Animacio {
  int radi1, radi2,roda1;

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
  roda1 = knob[1]*50;
  
  }

  /**
   * Mètode per a càlculs, si cal
   */
  void run() {}

  /**
   * Mètode equivalent al draw()
   */
  void display() {
   radi1 = slider[1];
   radi2 = slider[2];
   roda1 = knob[1]*50;
   background(roda1,roda1,roda1);
    fill(HSB, 255,255,255);
   ellipse(width/2, height/2, radi1*2, radi1*2);

   fill(HSB, 120,100,160);
   ellipse(width/2, height/2, radi2*2, radi2*2);
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
