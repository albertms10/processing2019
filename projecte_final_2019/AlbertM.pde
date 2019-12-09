class AlbertM extends Animacio {
  int n;
  ArrayList<Fly_AM> flies = new ArrayList<Fly_AM>();
  float songLength;
  Wind wind;

  AlbertM(String songName) {
    super(songName);

    n = 1;
    wind = new Wind(10);

    init();
    song.play();
  }

  void init() {
    colorMode(HSB, 360, 100, 100, 100);
    bgColor = color(360);
    background(bgColor);

    fft = new FFT(song.bufferSize(), song.sampleRate());
    songLength = song.length();

    for (int i = 0; i < n; i++) {
      flies.add(new Fly_AM(width * .1, height * .1));
    }
  }

  void run() {
  }

  void display() {
    background(bgColor);

    wind.draw();

    for (Fly_AM fly : flies) {
      fly
        .move(map(song.position(), 0, songLength, 0, width), map(highestAmp(), 1100, 0, 0, height))
        .setRad(10)
        .draw();
      fill(360);
    }
  }

  float highestAmp() {
    float highestAmp = 0;
    float frequency = 0;

    fft.forward(song.left);

    for (int i = 0; i < 20000; i++) {
      float amplitude = fft.getFreq(i);
      if (amplitude > highestAmp) {
        highestAmp = amplitude;
        frequency = i;
      }
    }

    return frequency;
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
