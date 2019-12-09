class AlbertF extends Animacio {
  color b1, b2, c1, c2;
  float kickSize;
  int radius;


  AlbertF(String songName) {
    super(songName);
    init();
    song.play();
  }

  void init() {

    background(200);
    noStroke();
    colorMode(HSB, 360, 100, 100);
    ellipseMode(RADIUS);


    kickSize = 32;
  }

  void run() {
  }

  void display() {

    c1 = color(knob[1], 81, 61);
    c2 = color(knob[1]+30, 81, 61);

    beat.detect(song.mix);
    background(255);


    for (int i = 0; i <= height; i++) {
      float inter = map(i, 0, height, 0, 1);
      color c = lerpColor(c1, c2, inter);
      stroke(c);
      line(0, i, width, i);
    }





    kickSize = constrain(kickSize * 0.95, 16, 100);


    if ( beat.isHat() ) kickSize = 100;




    radius=(slider[1])*2;
    //radius=100;
    float h = 20;
    for (int r = radius; r > 0; --r) {
      noStroke();
      fill(h, 90, 80);
      ellipse(width/2, height/2, r+kickSize, r+kickSize);

      h = (h + 0.1) %360;


      //ellipse(width/2, height/2, kickSize, kickSize);
      println(frameRate);
    }
  }


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
