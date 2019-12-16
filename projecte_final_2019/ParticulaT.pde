class ParticulaT { 
  PVector posicio;
  PVector velocitat;
  PVector acceleracio;
  float massa = 8;

  float amortiment = 0.95;

  // Interaccio amb el ratoli
  PVector dragOffset;
  boolean dragging = false;

  // Constructora
  ParticulaT(float x, float y) {
    posicio = new PVector(x, y);
    velocitat = new PVector();
    acceleracio = new PVector();
    dragOffset = new PVector();
  } 

  // Integracio d'Euler
  void mou() { 
    velocitat.add(acceleracio);
    velocitat.mult(amortiment);
    posicio.add(velocitat);
    acceleracio.mult(0);
  }

  // Newton's law: F = M * A
  void applyForce(PVector force) {
    PVector f = force.copy();
    f.div(massa);
    acceleracio.add(f);
  }

  // Dibuixa la particula
  void dibuixa() { 
    noStroke();
    //fill(255, 0, 100);
    if (dragging) {
      // fill(80, 100, 255);
    }
    //ellipse(posicio.x, posicio.y, massa, massa);
  } 

  // Funcions per a la interaccio amb el ratoli
  // Comprova si hem clicat sobre la particula
  void clicked(int mx, int my) {
    float d = dist(mx, my, posicio.x, posicio.y);
    if (d < massa) {
      dragging = true;
      dragOffset.x = posicio.x-mx;
      dragOffset.y = posicio.y-my;
    }
  }

  void stopDragging() {
    dragging = false;
  }

  void drag(int mx, int my) {
    if (dragging) {
      posicio.x = mx + dragOffset.x;
      posicio.y = my + dragOffset.y;
    }
  }
}







class ParticulaTT { 
  PVector posicio;
  PVector velocitat;
  PVector acceleracio;

  float massa;


  // Interaccio amb el ratoli
  PVector dragOffset;
  boolean dragging = false;



  // Constructora
  ParticulaTT(float x, float y) {
    posicio = new PVector(x, y);
    dragOffset = new PVector();
    velocitat = new PVector(0, 0);
    acceleracio=new PVector(0, 0);
    massa=2;
  } 

  void aplicarForca(PVector force) {
    PVector f = PVector.div(force, massa);
    acceleracio.add(f);
  }

  void update() {
    velocitat.add(acceleracio);
    posicio.add(velocitat);

    acceleracio.mult(0);
  }



  // Dibuixa la particula
  void dibuixa() { 
    noStroke();
    fill(0, 0, 0);
    if (dragging) {
      fill(80, 100, 255);
    }
    ellipse(posicio.x, posicio.y, 20, 20);
  } 

  // Funcions per a la interaccio amb el ratoli
  // Comprova si hem clicat sobre la particula
  void clicked(int mx, int my) {
    float d = dist(mx, my, posicio.x, posicio.y);
    if (d < 20) {
      dragging = true;
      dragOffset.x = posicio.x-mx;
      dragOffset.y = posicio.y-my;
    }
  }

  void stopDragging() {
    dragging = false;
  }

  void drag(int mx, int my) {
    if (dragging) {
      posicio.x = mx + dragOffset.x;
      posicio.y = my + dragOffset.y;
    }
  }


  void checkEdges() {
    if (posicio.x > width) {
      posicio.x = width;
      velocitat.x *= -1;
    } else if (posicio.x < 0) {
      velocitat.x *= -1;
      posicio.x = 0;
    }

    if (posicio.y > height) {
      // Even though we said we shouldn't touch location and velocity directly, there are some exceptions.
      // Here we are doing so as a quick and easy way to reverse the direction of our object when it reaches the edge.
      velocitat.y *= -1;
      posicio.y = height;
    }else if (posicio.y < 0) {
      velocitat.y *= -1;
      posicio.y = 0;
    }
  }
}
