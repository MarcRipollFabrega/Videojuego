class Fons {
  /**************************************************************************Variables **********************************/
  // Imatge de fons amb llicencia gratuita, autor rawpixel.com
  //https://www.freepik.es/vector-gratis/silueta-horizonte-ilustracion_3786390.htm#fromView=search&page=1&position=26&uuid=ea8c5d4c-2d65-4dfe-a37a-2f25347e9179
  // Imatge terreny amb llicencia gratuita, autor macrovector
  // https://www.freepik.es/vector-gratis/conjunto-fondo-fisuras-capas-juegos-computadora_4282636.htm#query=suelo%20tierra&position=5&from_view=keyword&track=ais_user&uuid=6ffd65d2-c40d-4a2e-b29f-05c8870de045
  // Imatge del cartell amb llicencia gratuita autor mocrovector
  //https://www.freepik.es/vector-gratis/ilustracion-vector-senal-trafico-verde-blanco_10601510.htm#fromView=search&page=1&position=52&uuid=5d2a0e82-1683-464f-9b94-6d3a0112c388
  /***********************************************************************************************************************/
  PImage fons, terreny, cartell; // Variables per guarda les imatges
  int num = 3;// Numero conte enrere
  int size = 150; // Mida del text del conte enrere
  PVector posició; // Vector per controlar la posició el text de compte enrere
  Fons() {
    fons = loadImage("fons.jpg"); // Carregar la imatge de fons
    terreny = loadImage("terreny.png"); // Carregar la imatge del terreny
    cartell = loadImage("cartell.png"); // Carregar la imatge del cartell
    posició = new PVector(width/2, 150); // Vector per la posició del text
  }
  void pantalla() {
    // Situa les diferents imatges en pantalla
    image(fons, width/2, height/2);
    image(cartell, width-150, height-225, 300, 270);
    image(terreny,width/2, height, 1380, 204);
  }
  void conteEnrere() {
    // Crear el compte enrere.
    textSize(size); // Mida del text
    fill(0, 0, 255); // Color del text
    text(num, posició.x, posició.y);  // Situa el text en pantalla
    size--; // Resta la mida del text
    if (size<50) { // Si la mida del text és inferior a 30, canvia de numero i situa el text a 150
      num--;
      size=150;
    }
    if (num < 1) { // Si num arriba a menor que 1, será 0
      num = 0; //Estableix el numero a 0
      posició.x = -100; // Treu de la pantalla el numero
    }
  }
}
