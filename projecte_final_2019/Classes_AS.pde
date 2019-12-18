class ASPunt {
  int xOffset;
  int yOffset;
  float x, y;
  int unit;
  int xDirection = 1;
  int yDirection = 1;
  float speed;
  float step = random(1, 10);
  int pas = 0;

  float plus = 0.8;

  color coloret = 255;
  Anna aux;

  // Contructor
  ASPunt(int xOffsetTemp, int yOffsetTemp, int xTemp, int yTemp, float speedTemp, int tempUnit, Anna a) {
    xOffset = xOffsetTemp;
    yOffset = yOffsetTemp;
    x = xTemp;
    y = yTemp;
    speed = speedTemp;
    unit = tempUnit;
    aux = a;
  }

  // Custom method for updating the variables
  void update() {
    if (aux.mode == 0) {
      //println("case = 0");
    }
    if (aux.mode == 1) {
      modeUno();
      //println("mode = 1");
    }
    if (aux.mode == 2) {
      modeDosDown();
      //println("mode = 2");
    }
    if (aux.mode == 3) {
      modeDosUp();
      //println("mode = 3");
    }
  }

  // Custom method for drawing the object

  void display() {

    if (aux.changeColor)
      coloret = color(random(255), random(255), random(255), random(255));

    fill(coloret);
    if (buttonS[3]) {
      tint(coloret);
      image(aux.img, xOffset + x, yOffset + y, knob[1], knob[1]);
    } else {
      aux.snareDMax = 1.5*height;
      ellipse (xOffset + x, yOffset + y, knob[1], knob[1]);
      //ellipse (xOffset + x, yOffset + y, 6, 6);
    }
  }

  void modeUno() {

    if (buttonS[1]) {
      speed = slider[1]/10;
      //speed = random(slider[1]/10, slider[2]/10);
    } else {
      speed = random(0.05, 0.8);
    }

    x = x + (speed * xDirection);
    if (x >= unit || x <= 0) {
      xDirection *= -1;
      x = x + (1 * xDirection);
      y = y + (1 * yDirection);
    }
    if (y >= unit || y <= 0) {
      yDirection *= -1;
      y = y + (1 * yDirection);
    }
  }

  void modeDosDown() {
    float step2 = knob[2];
    //plus = slider[2]/127;
    if (slider[2]==0 && pas==0) {
      pas = 1;
      slider[2]=127;
    } else {
      plus = map(slider[2], 0, 127, 0, 0.8);
    }
    x = x + (speed * xDirection);
    if (x >= unit || x <= 0 ) {
      xDirection *= -1;
      x = x + (1 * xDirection);
      y = y + step2 + (1 * yDirection);
    }
    if (speed>plus) {
      y = y + step;
      //println(vel);
    }
  }

  void modeDosUp() {
    float step2 = knob[2];
    if (slider[2]==0) {
      slider[2]=127;
    } else {
      plus = map(slider[2], 0, 127, 0, 0.8);
    }
    x = x + (speed * xDirection);
    if (x >= unit || x <= 0) {
      xDirection *= -1;
      x = x + (1 * xDirection);
      y = y - step2;
    }
    if (speed>plus) {
      y = y - step - (1 * yDirection);
      //println(vel);
    }
  }
}

class StarPower {
  float life;
  int rad1; //30
  int rad2; //70
  color colorEstrella;

  StarPower() {
    life = 0;
    rad1 = 0;
    rad2 = 40;
    colorEstrella = color(random(255),random(255), random(150,255));
  }

  void bright() {
    fill(colorEstrella, (100-life)*255/100);
    star(width / 2, height / 2, rad1, rad2, 5);
    life++;
    rad1 = rad1 + 5;
    rad2 = rad2 + 10;
  }
}

void star(float x, float y, float radius1, float radius2, int npoints) {
  float angle = TWO_PI / npoints;
  float halfAngle = angle/2.0;
  beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius2;
    float sy = y + sin(a) * radius2;
    vertex(sx, sy);
    sx = x + cos(a+halfAngle) * radius1;
    sy = y + sin(a+halfAngle) * radius1;
    vertex(sx, sy);
  }
  endShape(CLOSE);
}
