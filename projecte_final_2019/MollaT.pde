class MollaT { 
  // Dues masses a cada extrem
  ParticulaT a;
  ParticulaT b;
  float lon; // longitud en repos 
  float k = 0.005; // constant de la molla
  int colorMolla;
  

  // Constructora
  MollaT(ParticulaT aa, ParticulaT bb, int l) {
    a = aa;
    b = bb;
    lon = l;
    colorMolla=255;
  } 

  // Calcula la forca de la molla i l'aplica a les dues particules
  void calculaForcaMolla() {
    // Vector entre les dues particules
    PVector forca = PVector.sub(this.a.posicio, this.b.posicio);
    // Distancia entre les dues particules
     float d =forca.mag();
    // Estirament de la molla
     float estirament = d-lon;
    // Aplica la llei de Hooke
    forca.normalize();
    forca.mult(-1*k*estirament);
    // F = k * estirament
    a.applyForce(forca);

}

  void setColorMolla(int colorMolla){
    this.colorMolla = colorMolla;
  }

  void dibuixa() {
    //CANVIAR COLOR
    color flagColor = color( this.colorMolla, 100, 100, 50);
    stroke(flagColor);
    
    line(a.posicio.x, a.posicio.y, b.posicio.x, b.posicio.y);
  }
}
