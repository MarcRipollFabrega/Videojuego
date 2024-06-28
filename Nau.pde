
// Classe Nau
class Nau {
  PVector posició = new PVector(500, 850); // Vector per controlar la posició de la nau
  boolean dreta, esquerra, tret = false; // Boolena per fer més fluid els moviments
  int cont; // Variable per limitar els trets seguits
  boolean escut = false;
  int velocitat = 10;
  public int potencia = 1; // Variable publica per controlar la potencia dels trets
  // Imatge de fons amb llicencia gratuita, autor upkfyak
  //https://www.freepik.es/vector-gratis/varias-esferas-luminosas-energia_9044524.htm#from_view=detail_alsolike
  PImage escutIMG; //Escut
  // Imatge de fons amb llicencia gratuita, autor freepik
  //https://www.freepik.es/vector-gratis/coleccion-adorable-naves-espaciales-diseno-plano_2857471.htm#fromView=search&page=4&position=34&uuid=37e7210f-f8ec-4774-b2eb-421f80da38ca
  PImage[] nau; // Nau
  Nau() {
    nau = new PImage[4];
    escutIMG = loadImage("escut.png"); //Carrega la imatge
    nau[1] = loadImage("nau-1.png"); //Carrega la imatge
    nau[2] = loadImage("nau-2.png"); //Carrega la imatge
    nau[3] = loadImage("nau-3.png"); //Carrega la imatge
  }
  void pantalla() {
    if (potencia == 1) {
      image(nau[1], posició.x, posició.y, 90, 95); // Crear la imatge
    } else if (potencia == 2) {
      image(nau[2], posició.x, posició.y, 90, 95); // Crear la imatge
    } else if (potencia == 3) {
      image(nau[3], posició.x, posició.y, 90, 95); // Crear la imatge
    }
    if (escut == true) {
      image(escutIMG, posició.x, posició.y, 110, 110); // Crear la imatge
    }
  }
  void moviment() {
    // Controlar el moviment de la nau dreta
    if (dreta == true) { // Si el boolen dreta és true
      // Situa la nau dins els limits de la pantalla dret
      if (posició.x > width) { // Si la posició de la nau X és superior a la pantalla
        posició.x = width-5; // Posició de la nau
      } else { // En cas contrari
        posició.x = posició.x+velocitat; // Posció X de la nau sumarem +3.
      }
    }
    // Controlar el moviment de la nau esquerra
    if (esquerra == true) { // Si el boolen esquerra és true
      // Situa la nau dins els limits de la pantalla esquerra
      if (posició.x <= 0) { // Si la posició de la nau X és inferior a 0
        posició.x = 5; // Posició de la nau
      } else { // En cas contrari
        posició.x = posició.x-velocitat; // Posció X de la nau sumarem +3.
      }
    }
    // Controlar el tret de la nau
    if (tret == true) { // Si el boolean tret és true
      cont ++; // Iniciar el comptador per controlar el nombre de trets
      if ( cont == 10) { // Cada 10 crear una nova bala
        efecteTret.rewind(); // retrocedeix efecte de so
        efecteTret.play(); // activa el so
        Bala aux = new Bala(new PVector(posició.x, posició.y)); // Crear la nova Bala de nom aux
        if (potencia == 2) { // Si la potencia = 2, crear dos bales
          bales.add(aux); // S'afegeix al ArrayList
          bales.add(aux); // S'afegeix al ArrayList
          bales.add(aux); // S'afegeix al ArrayList
        }
         else if (potencia == 3) {
          bales.add(aux); // S'afegeix al ArrayList
          bales.add(aux); // S'afegeix al ArrayList
          bales.add(aux); // S'afegeix al ArrayList
          bales.add(aux); // S'afegeix al ArrayList
          bales.add(aux); // S'afegeix al ArrayList
        } else if (potencia == 1) { // Si la potencia = 1, només crea una bala

          bales.add(aux); // S'afegeix al ArrayList
        }
        cont = 0; // Reinicia el comptador
      }
    }
  }
  // Metode segons la tecla polsada
  void teclaPolsada( int tecla) {
    if (tecla == RIGHT) {
      dreta = true; // Boolean dreta será true
    }
    if (tecla == LEFT) {
      esquerra = true; // Boolean esquerra será true
    }
    if (tecla == 32) {// Tecla espai
      tret = true; // Boolean tret será true
    }
  }
  // Metode segons la tecla soltada
  void teclaDeixada( int tecla) {
    if (tecla == RIGHT) {
      dreta = false; // Boolean dreta será false
    }
    if (tecla == LEFT) {
      esquerra= false; // Boolean esquerra será false
    }
    if (tecla == 32) {
      tret = false; // Boolean tret será false
    }
  }
}
