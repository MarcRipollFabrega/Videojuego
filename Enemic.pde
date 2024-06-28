// Enemic
 PImage[] enemicIMG;
class Enemic {
  public PVector posició, velocitat, gravetat; // Vectors per controlar la posició, velocitat i gravetat
  int tipus;
  float diametre; // Variable per controlar el dimatre de cada enemic
  int numero; // Variable per controlar la duresa.
  Enemic (PVector pos, float diam, int num, PVector vel) {
    posició = new PVector(pos.x, pos.y); // Assignar els valors de posició
    velocitat = new PVector(vel.x, vel.y); // Assignar la velocitat
    gravetat = new PVector(0.0, 0.2); // Assignar la gravetat
    diametre = diam; // Assignar el diametre
    numero = num; // Assignar la duresa
    //Segons el tipus aleatori, surt una imatge enemic
    tipus = int(random(1,6));
    enemicIMG = new PImage[7];
    enemicIMG[1] = loadImage("enemic1.png");
    enemicIMG[2] = loadImage("enemic2.png");
    enemicIMG[3] = loadImage("enemic3.png");
    enemicIMG[4] = loadImage("enemic4.png");
    enemicIMG[5] = loadImage("enemic5.png");
    enemicIMG[6] = loadImage("enemic6.png");
  }
  void pantalla() {
    image(enemicIMG[tipus], posició.x, posició.y, diametre, diametre);

    // Text
    fill(255); // Color
    textSize(30); // mida
    text(numero, posició.x, posició.y+10); // dibuixa el text
  }
  void moviment() {
    velocitat.x = (velocitat.x * 1);
    posició.add(velocitat); // suma al vector posició la velocitat

    velocitat.add(gravetat); // suma al vector velocitat la gravetat
    if ((posició.x > width-diametre/2) || (posició.x < 0+diametre/2)) { // Si l'enemic choca amb els costats de la pantalla
      velocitat.x = velocitat.x * -1; // Efectuar el rebot
      efecteRebot.rewind();
      efecteRebot.play();
    }
    if (posició.y > height-100) { // Si choca amb la part inferior de la pantalla
      velocitat.y = velocitat.y * -0.95; // Rebota l'enemic
      posició.y = height-100; // // Situa l'enemic
       efecteRebot.rewind();
       efecteRebot.play();
    }
  }
}
