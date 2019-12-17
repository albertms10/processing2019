class Fly {
  PVector pos;
  float rad;
  float angle;
  float timeOffset;
  Wings wings;
  FlyDie flyDie;

  final float EASING = .01;
  final float ROTATION_AMOUNT = 1.2;

  Fly(float x, float y) {
    pos = new PVector(x, y);
    rad = random(10, 20);
    angle = 0;
    wings = new Wings(this);
  }

  Fly(float x, float y, float timeOffset) {
    this(x, y);
    this.timeOffset = timeOffset;
  }

  Fly setX(float x) {
    pos.x = x % width;
    return this;
  }

  Fly setY(float y) {
    pos.y = y;
    return this;
  }

  Fly incrementX(float dx) {
    pos.x += dx;
    return this;
  }

  Fly incrementY(float dy) {
    pos.y += dy;
    return this;
  }

  Fly setPos(float x, float y) {
    setX(x);
    setY(y);
    return this;
  }

  Fly setRad(float rad) {
    this.rad = rad;
    return this;
  }

  Fly incrementAngle(float dAngle) {
    angle = angle + dAngle;
    return this;
  }

  Fly move(float desiredX, float desiredY) {
    setX(desiredX - timeOffset * AlbertM.SPEED - width * .03);
    float dY = desiredY - pos.y;
    incrementY(dY * EASING);

    if (abs(angle) <= ROTATION_AMOUNT) {
      incrementAngle((dY > 0 ? 1 : -1) * ROTATION_AMOUNT * EASING);
    } else {
      angle -= .1;
    }

    return this;
  }

  void draw() {
    pushMatrix();

    translate(pos.x, pos.y);
    rotate(angle);

    noStroke();
    fill(41);
    ellipse(0, 0, rad, rad);

    wings
      .move()
      .draw();

    popMatrix();
  }

  void die() {
    flyDie = new FlyDie(this);
  }
}

class FlyDie {
  Fly fly;
  float easing;

  FlyDie(Fly fly) {
    this.fly = fly;
    this.easing = 1.001;
  }

  void draw() {
    easing *= 1.001;
    fly.pos.mult(easing);
    fly.draw();
  }
}

class Wings {
  Fly fly;
  float pos;
  float w;
  float h;

  Wings(Fly fly) {
    this.fly = fly;
    this.w = fly.rad * .7;
  }

  Wings move() {
    pos = -fly.rad / 3;
    h = (frameCount / 3) % 3 == 0 ? w : w / 2;
    return this;
  }

  void draw() {
    noStroke();
    fill(360, 80);
    ellipse(pos, pos, w, h);
  }
}

class ThunderStorm {
  ArrayList<Thunder> thunders;

  ThunderStorm() {
    thunders = new ArrayList<Thunder>();
  }

  void draw() {
    if (buttonM[1]) {
      thunders.add(new Thunder());
      buttonM[1] = false;
    }
    
    if (frameCount % 600 == 0) thunders.add(new Thunder(random(width), color(0, 70, 70)));

    for (int i = thunders.size() - 1; i >= 0; i--) {
      Thunder thunder = thunders.get(i);
      if (thunder.life <= 0) thunders.remove(thunder);
      thunder.draw();
    }
  }
}

class Thunder {
  float x;
  float extension;
  float life;
  color lightColor;
  AudioPlayer thunderSound;

  Thunder(float x, color lightColor) {
    this.x = x;
    extension = 5;
    life = 100;
    thunderSound = minim.loadFile("thunder.mp3");
    thunderSound.play();
    thunderSound.setGain(.01);
    this.lightColor = lightColor;
  }

  Thunder() {
    this(map(knob[1], 0, SLIDER_MAX_VALUE, width * .05, width * .95), 360);
  }

  void draw() {
    noStroke();
    fill(lightColor, life - 50);
    rect(0, 0, width, height);

    stroke(360, life);
    strokeWeight(extension * 2);
    line(x + random(-5, 5), 0, x + random(-5, 5), height);

    life--;
  }
}

class WaterDrop {
  float frequency;
  ArrayList<Drop> drops;

  WaterDrop() {
    drops = new ArrayList<Drop>();
    this.frequency = 10;
  }

  void draw() {
    frequency = map(slider[2], 0, SLIDER_MAX_VALUE, 10, 1);
    if (frameCount % (int) frequency == 0) drops.add(new Drop());

    for (int i = drops.size() - 1; i >= 0; i--) {
      Drop drop = drops.get(i);

      if (drop.pos.y > height) {
        drops.remove(drop);
      } else {
        if (drop.dropDie == null) {
          drop
            .move()
            .draw();
        } else {
          drop.dropDie.draw();
        }
      }
    }
  }
}

class Drop {
  PVector pos;
  float len;
  float offset;
  float increment;
  DropDie dropDie;

  Drop() {
    this.pos = new PVector(random(width), 0);
    this.len = random(5, 30);
    offset = random(5, 10);
    increment = random(1, 1.05);
  }

  Drop move() {
    offset *= increment;
    pos.x += offset * .1;
    pos.y += offset;
    return this;
  }

  Drop draw() {
    stroke(360, 50);
    strokeWeight(2);
    line(pos.x, pos.y, pos.x, pos.y + len);

    return this;
  }

  void die() {
    dropDie = new DropDie(this);
  }
}

class DropDie {
  Drop drop;
  float life;
  float dieSpeed;
  static final float MAX_LIFE = 100;

  DropDie(Drop drop) {
    this.drop = drop;
    life = 0;
    dieSpeed = random(1.5, 3);
  }

  void draw() {
    noFill();
    strokeWeight(drop.len / 5);
    stroke(360, (MAX_LIFE - life) / AlbertM.SPEED);
    ellipse(
      drop.pos.x, 
      drop.pos.y, 
      drop.len / 2 + life, 
      drop.len / 2 + life
      );
    life += dieSpeed;
  }
}
