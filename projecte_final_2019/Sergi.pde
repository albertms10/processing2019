class SergiA extends Animacio {
  int radi1;

  SergiA(String songName) {
    super(songName);
    init();
    song.play();
  }

  /**
   * Mètode equivalent al setup()
   */
  void init() {
   ellipseMode(RADIUS);
  colorMode(HSB, 127);
  radi1 = slider[1];
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
   background(127,0,127);
   ellipse(width/2, height/2, radi1*2, radi1*2);
    
  }
  
  /**
   * Aquestes funcions (potser no calen totes)
   * les haurem de programar com si fossin les funcions de teclat i ratolí.
   * Les cridem des del programa principal quan la nostra animació està activa.
   */
   
   
  void f_keyPressed() {}
  
  void f_keyReleased() {}

  void f_mousePressed() {}

  void f_mouseDrgged() {}

  void f_mouseReleased() {}
  
}
