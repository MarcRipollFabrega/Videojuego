class Potenciador {
  /**********************************************************************************Variables***********************************************************************************************************************/
  PImage [] regal;
  PVector posició, velocitat, gravetat;
  boolean millorar;
  int tipusRegal;
  
  Potenciador()  {
    posició = new PVector(0, 0); // Assignar els valors de posició
    velocitat = new PVector(0.0, 2.1); // Assignar la velocitat
    gravetat = new PVector(0.0, 0.2); // Assignar la gravetat
// Carregar les diferents imatges
    regal = new PImage[6];
    regal[0] = loadImage("arma+1.png");
    regal[1] = loadImage("arma-1.png");
    regal[2] = loadImage("arma+2.png");
    regal[3] = loadImage("arma-2.png");
    regal[4] = loadImage("escut+.png");
    regal[5] = loadImage("escut-.png");
    
    millorar = false;
  }
  void pantalla() {
    if (tipusRegal == 1 || tipusRegal == 3 || tipusRegal == 5) {
      tint(255, 0, 0);
    }
    image(regal[tipusRegal], posició.x, posició.y, 47, 53); // Dibuixar el tret
    noTint();
  }
  void moviment() {
    posició.add(velocitat);
    velocitat.add(gravetat); // suma al vector velocitat la gravetat
    if (posició.y > height-100) { // Si choca amb la part inferior de la pantalla
      posició.y = height-100; // // Situa el potenciador
    }
  }
}
