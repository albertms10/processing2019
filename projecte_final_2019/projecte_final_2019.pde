import themidibus.*;

import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;

Minim minim;
AudioPlayer song;
BeatDetect beat;
FFT fft;

Animacio a;
boolean animationOn;

/** 
 * Variables per a la controladora MIDI
 * Les variables són globals i es poden utilitzar dins de les classes
 * Les funcions de gestió del MIDI s'han de cridar des de la classe principal
 */
MidiBus bus;
int[] slider = new int[10];
int[] knob = new int[10];
boolean[] buttonR = new boolean[10];
boolean[] buttonM = new boolean[10];
boolean[] buttonS = new boolean[10];

color bgColor = 0;

void setup() {
  size(1000, 800, P2D);
  // fullScreen(P2D);
  
  minim = new Minim(this);

  /**
   * En inicialitzar el MIDI, hem de veure quin nom
   * li dona Processing a la controladora.
   * Ho fem amb la instruccio MidiBus.list().
   * Després, posarem el nom que ens interessi a la creadora del bus.
   */
  // MidiBus.list();
  bus = new MidiBus(this, "nanoKONTROL2", -1); 
  // bus = new MidiBus(this, "nan0KONTROL", -1);

  animationOn = false;
}

void draw() {
  // println(frameRate);
  if (animationOn) {
    a.run();
    a.display();
  } else {
    background(0);
  }
}

void keyPressed() {
  if (animationOn) {
    if (key == '0') {
      song.close();
      animationOn = false;
      bgColor = 0;
    } else {
      a.f_keyPressed();
    }
  } else {
    switch (key) {
      case '1':
        a = new Maria("puzzle.mp3");
        animationOn = true;
        break;
        
      case '2':
        a = new AlbertM("flight.mp3");
        animationOn = true;
        break;
        
      case '3':
        a = new Anna("songAnnaS.mp3");
        animationOn = true;
        break;
        
      case '4':
        a = new AlbertF("songAlbertF.mp3");
        animationOn = true;
        break;
        
      case '5':
        a = new Sergi("songSergiA.mp3");
        animationOn = true;
        break;
        
      case '6':
        a = new Tomas("songTomas.mp3");
        animationOn = true;
        break;
    }
  }
}

void controllerChange(int channel, int number, int value) {
  // println("Channel:" + channel);
  // println("Number:" + number);
  // println("Value:" + value);

  if (number % 10 == 1) {
    slider[number / 10] = value;
  }

  if (number % 10 == 5) {
    knob[number / 10] = value;
  }

  /**
   * Els botons que tenen la lletra 'S' son instantanis.
   * Serveixen per a disparar coses.
   * Posem la variable a 'true' quan és diferent de zero. 
   * Només actua mentre el botó està apretat.
   */
  if (number % 10 == 4) {
    buttonS[number / 10] = (value != 0);
  }
  
  /**
   * Els botons que tenen la lletra 'M' o 'R' canvien cada vegada
   * de 0 a 1 o de 1 a 0 (a vegades, de 0 a 127 o de 127 a 0).
   * Quan és diferent de zero, posem la variable a 'true'.
   * Quan el botó té llum, el valor és diferent de zero.
   */
  if (number % 10 == 3) {
    buttonM[number / 10] = (value != 0);
  }

  if (number % 10 == 2) {
    buttonR[number / 10] = (value != 0);
  }
}
