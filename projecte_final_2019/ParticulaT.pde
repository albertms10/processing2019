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
