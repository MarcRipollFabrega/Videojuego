// Classe Bala
class Bala {
  PVector posició = new PVector(0, 0); // Vector per controlar la posició del tret
  int velocitat = 8; // Velocitat de les bales
  // Imatge de bala amb llicencia gratuita, autor upklyak
  //https://www.freepik.es/vector-gratis/jetpack-llamas-fuego-azul-claro-cohete-espacial_30698230.htm#fromView=search&page=1&position=3&uuid=214098ac-c173-4c33-8f7e-13d79a4b098d
  PImage bala;

  Bala(PVector pos) {

    posició.x = pos.x; //Asignar el valor pos.x a el vector posició.x
    posició.y = pos.y; //Asignar el valor pos.y a el vector posició.y
    bala = loadImage("bala.png");
  }
  void pantalla() {
    if (nau.potencia == 2) { // Si la potencia = 2, dibuixar 2 bales
      image(bala, posició.x-40, posició.y-10, 5, 10); // Dibuixar el tret
      image(bala, posició.x, posició.y-40, 5, 10); // Dibuixar el tret
      image(bala, posició.x+40, posició.y-10, 5, 10); // Dibuixar el tret
    } else if (nau.potencia == 3) { // Si la potencia = 2, dibuixar 2 bales
      image(bala, posició.x-40, posició.y-10, 5, 10); 
      image(bala, posició.x-25, posició.y-20, 5, 10); // Dibuixar el tret
      image(bala, posició.x, posició.y-40, 5, 10); // Dibuixar el tret
      image(bala, posició.x+25, posició.y-20, 5, 10); // Dibuixar el tret
      image(bala, posició.x+40, posició.y-10, 5, 10); // Dibuixar el tret
    } else if (nau.potencia == 1) { // Si la potencia = 1, dibuixar 1 bala
      image(bala, posició.x, posició.y-40, 5, 10); // Dibuixar el tret
    }
  }
  void moviment() {
    if (nau.potencia == 1) {
    posició.y = posició.y - velocitat*2; // Mou el tret
    } else {
      posició.y = posició.y - velocitat; // Mou el tret
    }
  }
}
