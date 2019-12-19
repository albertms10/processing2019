class AlbertM extends Animacio {
  ArrayList<Fly> flies;
  ArrayList<Float> amplitudes;
  float songLength;
  float highestAmp;
  ThunderStorm thunderStorm;
  WaterDrop waterDrop;

  static final int SPEED = 5;

  AlbertM(String songName) {
    super(songName);

    flies = new ArrayList<Fly>();
    amplitudes = new ArrayList<Float>();
    waterDrop = new WaterDrop();
    thunderStorm = new ThunderStorm();

    init();
    song.play();
  }

  void init() {
    colorMode(HSB, 360, 100, 100, 100);

    fft = new FFT(song.bufferSize(), song.sampleRate());
    songLength = song.length();
    amplitudes.add(height * .9);

    flies.add(new Fly(width * .1, height * .1));
    
    buttonS[1] = true;
    knob[1] = SLIDER_MAX_VALUE / 2;
    knob[2] = SLIDER_MAX_VALUE / 2;
  }

  void run() {
    if (buttonS[1] && frameCount % (int) map(knob[1], 0, SLIDER_MAX_VALUE, 60 * 3, 20) == 0) addFly();
  }

  void display() {
    float currentSongPosition = song.position();
    background(map(currentSongPosition, 0, songLength, 0, 330), 70, 70);

    if (frameCount % 10 == 0) {
      highestAmp = highestAmp();
      amplitudes.add(highestAmp);
    }

    waterDrop.draw();
    thunderStorm.draw();

    for (int i = 0; i < flies.size(); i++) {
      Fly fly = flies.get(i);

      if (waterDrop.drops.size() > 0) {
        for (int j = waterDrop.drops.size() - 1; j >= 0; j--) {
          Drop drop = waterDrop.drops.get(j);
          if (drop.dropDie == null) {
            if (drop.pos.dist(fly.pos) <= fly.rad) drop.die();
          } else {
            if (drop.dropDie.life >= DropDie.MAX_LIFE) {
              drop.dropDie = null;
              waterDrop.drops.remove(drop);
            }
          }
        }
      }

      if (thunderStorm.thunders.size() > 0) {
        for (int j = thunderStorm.thunders.size() - 1; j >= 0; j--) {
          Thunder thunder = thunderStorm.thunders.get(j);
          if (fly.flyDie == null) {
            if (thunder.x - thunder.extension <= fly.pos.x + fly.rad
              && thunder.x + thunder.extension >= fly.pos.x - fly.rad
              && thunder.life > 50) fly.die();
          } else {
            if (fly.pos.y > height) {
              fly.flyDie = null;
              flies.remove(fly);
            }
          }
        }
      }

      if (buttonM[1]) fly.finish(random(-150, width + 150), -height);

      if (fly.endPos == null) {
        if (fly.flyDie == null) {
          fly
            .move(
            map(currentSongPosition, 0, songLength / SPEED, width * .03, width * .97), 
            map(amplitudes.get((int) (amplitudes.size() - 1 - fly.timeOffset / SPEED)), 1100, 0, height * .03, height * .97)
            )
            .draw();
        } else {
          fly.flyDie.draw();
        }
      } else {
        fly.move().draw();
      }
    }
    
    if (buttonM[1]) buttonM[1] = false;
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
    addFly();
  }

  void f_keyReleased() {
  }

  void f_mousePressed() {
  }

  void f_mouseDragged() {
  }

  void f_mouseReleased() {
  }

  boolean addFly() {
    return flies.add(new Fly(
      width * .1, 
      random(height *.1, height * .9), 
      map(song.position(), 0, songLength, 0, width))
      );
  }
}
