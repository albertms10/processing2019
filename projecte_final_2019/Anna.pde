class Anna extends Animacio {

  //Grafic
  ASPunt snare;
  PImage img;

  float d, dMax, c;
  float snareD, snareDMax, snareC;

  int unit = 40;
  int count;
  ASPunt[] mods;
  boolean changeColor;

  ArrayList<StarPower> starPowers;

  int mode = 1;
  //0 = R(1) moviment
  //1 = M(1) no moviment
  //2 = R(2) down
  //3 = M(2) up

  Anna(String nameSong) {
    super(nameSong);
    init();
    song.play();
  }

  /**
   * Mètode equivalent al setup()
   */
  void init() {
    imageMode(CENTER);
    img = loadImage("data/pineappleAnna.png");
    noStroke();

    //int wideCount = 5;
    int wideCount = width / unit;
    //int highCount = 5;
    int highCount = height / unit;
    count = wideCount * highCount;
    mods = new ASPunt[count];

    int index = 0;
    for (int y = 0; y < highCount; y++) {
      for (int x = 0; x < wideCount; x++) {
        mods[index++] = new ASPunt(x*unit, y*unit, unit/2, unit/2, random(0.05, 0.8), unit, this);
      }
    }
    //println(highCount*wideCount);
    //println(index);

    starPowers = new ArrayList<StarPower>();
  }

  /**
   * Mètode per a càlculs, si cal
   */
  void run() {

    if (buttonM[1]) {
      mode=0;
      //println("mode = 0");
    }
    if (buttonR[1]) {
      mode=1;
      //println("mode = 1");
    }
    if (buttonM[3]) {
      init();
    }
    if (buttonS[2]) {
      if (buttonR[2]) {
        mode=2;
        //println("mode = 2");
      }
      if (buttonM[2]) {
        mode=3;
        //println("mode = 3");
      }
    } else {
      mode=1;
    }
  }

  /**
   * Mètode equivalent al draw()
   */
  void display() {
    background(0);

    if (buttonR[3]) {
      starPowers.add(new StarPower());
    }

    for (int i = 0; i< starPowers.size(); i++) {
      StarPower starPower = starPowers.get(i);
      if (starPower.life <= 100) starPower.bright();
    }
    for (int i = starPowers.size() - 1; i >= 0; i--) {
      StarPower starPower = starPowers.get(i);
      if (starPower.life > 100) //starPower.bright();
      starPowers.remove(starPower);
    }

    beat.detect(song.mix);

    checkSnare();
    for (ASPunt mod : mods) {
      mod.update();
      mod.display();
    }
  }

  /**
   * CHECK BEATS
   */
  void checkSnare() {

    changeColor = false;
    if ( beat.isSnare() ) {
      snareC = 3;
      changeColor = true;
    } else {
      snareC = 1;
    }

    snareD *= snareC;

    if      (snareD > snareDMax) snareD = snareDMax;
    else if (snareD < 0.1*snareDMax) snareD = 0.1*snareDMax;
  }

  /**
   * Aquestes funcions (potser no calen totes)
   * les haurem de programar com si fossin les funcions de teclat i ratolí.
   * Les cridem des del programa principal quan la nostra animació està activa.
   */
  void f_keyPressed() {
  }

  void f_keyReleased() {
  }

  void f_mousePressed() {
  }

  void f_mouseDragged() {
  }

  void f_mouseReleased() {
  }
}
