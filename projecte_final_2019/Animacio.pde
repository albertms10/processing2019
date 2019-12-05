/**
 * Aquesta classe només de lectura
 */

abstract class Animacio {
  Animacio(String nameSong) {
    setupMusica(nameSong);
  }

  void setupMusica(String nameSong) {
    song = minim.loadFile(nameSong);
    beat = new BeatDetect(song.bufferSize(), song.sampleRate());

    beat.setSensitivity(300);
  }

  /**
   * Mètode equivalent al setup()
   */
  abstract void init();

  /**
   * Mètode per a càlculs, si cal
   */
  abstract void run();

  /**
   * Mètode equivalent al draw()
   */
  abstract void display();

  /**
   * Aquestes funcions (potser no calen totes)
   * les haurem de programar com si fossin les funcions de teclat i ratolí.
   * Les cridem des del programa principal quan la nostra animació està activa.
   */
  abstract void f_keyPressed();

  abstract void f_keyReleased();

  abstract void f_mousePressed();

  abstract void f_mouseDrgged();

  abstract void f_mouseReleased();
}
