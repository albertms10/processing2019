class Tomas extends Animacio {

  ParticulaT[] partis = new ParticulaT[7];
  ParticulaTT[] partisTT = new ParticulaTT[4];
  MollaT[] molles = new MollaT[6];

  float angle=0;
  float speed=0.02;
  boolean active1, active2, active3, active4, active5, active6;
  int radi1, radi2;
  int colorMolla=0;
  float yoff = 0.0;
  float velY=0.5;
  int cx;
  int wx=0;
  int hy=0;

  Tomas(String songName) {
    super(songName);
    init();
    song.play();
  }

  void init() {

    active1=false;
    radi1 = radi2 = 0;
    cx=width/2;

    //background(0); 
    ellipseMode(RADIUS);
    colorMode(HSB);

    for (int i = 0; i < partis.length; i++) {
      partis[i] = new ParticulaT(width/2, i*40);
    }

    for (int i = 0; i < molles.length; i++) {
      molles[i] = new MollaT(partis[i], partis[i+1], 40);
    }

    //////////////PARTICULES ONES
    for (int i = 0; i < partisTT.length; i++) {
      partisTT[i] = new ParticulaTT(width/2, (i+5)*40);
    }
  }

  void run() {
  }

  void display() {

    //BORRAR BACKGROUND
    //background(255); 
    active1=buttonS[1]; //ACTIVA MOLLES
    radi1=slider[1]; //POSICIO PARTICULES
    radi2=slider[2]; //POSICIO PARTICULES
    colorMolla=slider[3]; //COLOR MOLLA

    active3=buttonS[4]; //RESET

    active4=buttonS[2];//
    active5=buttonS[5];
    active6=buttonM[5];


    ///////////////////////////////ONES MOUNTAIN/////////////////////////////////////////
    if (active4) {
      fill(255);
      stroke(0);
      // We are going to draw a polygon out of the wave points
      beginShape(); 
      velY=velY+0.1;
      float xoff = 0;  // Option #1: 2D Noise


      // Iterate over horizontal pixels
      for (float x = 0; x <= width; x += 10) {
        // Calculate a y value according to noise, map to 
        float y = map(noise(xoff, yoff), 0, 1, 300+velY, 50+velY); // Option #1: 2D Noise
        // float y = map(noise(xoff), 0, 1, 200,300);    // Option #2: 1D Noise

        // Set the vertex
        vertex(x, y); 
        // Increment x dimension for noise
        xoff += 0.05;
      }
      // increment y dimension for noise
      yoff += 0.01;
      vertex(width, height);
      vertex(0, height);
      endShape(CLOSE);
    }


    ///////////////////////////////////////////////RESET///////////////////////////////////////
    if (active3) {
      fill(0);
      wx=wx+2;
      hy=hy+2;

      ellipse(width/2, height/2, wx, hy);
    }
    if(active3==false){
      wx=0;
      hy=0;
    }

    ///////////////////////////////////VISUALS MOLLA INTERACTIU /////////////////////////////////
    if (active1) {
      println("ACTIVE 1:"+active1);
      partis[6].dragging=true;
      println("Pista1:"+radi1);
      println("Pista2:"+radi2);
      for (MollaT m : molles) {
        m.setColorMolla(colorMolla);
        m.calculaForcaMolla();
        m.dibuixa();
      }

      for (ParticulaT p : partis) {
        p.mou();
        p.dibuixa();
        p.drag((int)map(radi1, 0, 127, 0, width), (int)map(radi2, 0, 127, 0, height));
      }
    }




    ///////////////////////////////////// PARTICULES ONES POS RANDOM//////////////////////////
    if (active5) {
      background(0);
      if (active6) {
        for (int i = 0; i < partisTT.length; i++) {
          partisTT[i].velocitat.x=(int)random(-2, 2);
          println(partisTT[i].velocitat.x);
          partisTT[i].velocitat.y=(int)random(-2, 2);
          println(partisTT[i].velocitat.y);
        }
      }
      for (ParticulaTT p : partisTT) {
        p.update();
        p.dibuixa();
        p.checkEdges();
        p.drag(mouseX, mouseY);
        int j=0;
        for (int i = 10; i<height; i+=10) {
          fill(200);
          //ellipse(cx, i, 10, 10);

          fill(255, 120, 120);
          //ellipse(cx+sin(angle)*30, i, 10, 10);

          fill(220, 0, 0);
          //ellipse(cx+sin(angle+j*PI/10)*30, i, 10, 10);
          //ellipse(50+sin(angle+j*PI/10)*80, i, 10, 10);
          stroke(255, 50);
          line(cx+sin(angle+j*PI/10)*30, i, p.posicio.x, p.posicio.y);

          j++;
        }
      }


      angle+=speed;
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
