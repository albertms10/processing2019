class Nom extends Animacio {
  Nom(String nameSong) {
    super(nameSong);
    init();
    song.play();
  }

  /**
   * Mètode equivalent al setup()
   */
  void init() {}

  /**
   * Mètode per a càlculs, si cal
   */
  void run() {}

  /**
   * Mètode equivalent al draw()
   */
  void display() {}
  
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
