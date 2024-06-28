/***********************************************************************************************************************************************************************************************************************************************/
// El joc està basat en el clàssic joc superpang però he creat la meva pròpia versió dins de les meves possibilitats i coneixements. Consisteix en moure una nau i anar disparant als diferents enemics que aniran rebotant en la pantalla
// El sistema de control és amb les fletxes de direcció i l'espai per disparar als diferents enemics
// He mirat d'incorporar tot el treballat en l'assignatura (Carregar taules, classes i funcions) a més he inclos altres elements (Com fisica, musica, efectes, col·lisions,..)

// Importem la llibreria per carregar la musica
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

/***************************************************************clases******************************************************/
Fons fons; // Clase del fons
Menu menu; // clase del menu
Nau nau;
Temporitzador temps; // Clase del temporitzador
ArrayList<Bala> bales = new ArrayList<Bala>(); // Array List per guardar les bales de la nau
ArrayList<Enemic> enemic = new ArrayList<Enemic>(); // Array list Enemigos
int contadorP, contadorEnemic = 0;
int punts;
int resultat;
int maxEnemic = 1;
Potenciador potenciador; // Clase del potenciador
// Arxius necesaris per carregar la musica
Minim minim;
AudioPlayer musica, efecteTret, efecteEscut, efecteInici, efecteRebot;


void setup() {
  size(1380, 965); // Mida de la pantalla
  surface.setTitle("Defensem la terra");
  /***********************************************************Carreguem les clases********************************************/
  menu = new Menu(); // clase del menu
  fons = new Fons(); // clase del fons
  temps = new Temporitzador(1000); // clase temporitzador
  nau = new Nau(); // Clase de la nau
  potenciador = new Potenciador(); // clase potenciador
  // Musica descarregada del web pixabay on pots descarregar musica lliure de drets d'autor
  //https://pixabay.com/es/music/search/juego/
  minim = new Minim(this);
  musica = minim.loadFile("chiptune-grooving-142242.mp3");  // carregar l'arxiu
  efecteTret = minim.loadFile("laser-gun-81720.mp3");  // carregar l'arxiu
  efecteEscut = minim.loadFile("ouch-116112.mp3");  // carregar l'arxiu
  efecteInici = minim.loadFile("game-start-6104.mp3");  // carregar l'arxiu
  efecteRebot = minim.loadFile("cartoon-jump-6462.mp3");  // carregar l'arxiu
  musica.loop();
}

void draw() {
  if (menu.botoPulsat== false) {
    imageMode(CENTER);
    /*********************************************************Menu************************************************************/
    menu.pantalla(); // Imatge del menu
    menu.moviment(); // Events del ratoli del menu
  }
  if (menu.botoPulsat== true) { // Si s'ha polsat el boto del menu
    /********************************************************Iniciar el joc***************************************************/

    // Fons
    fons.pantalla(); // Carregar el fons
    fons.conteEnrere(); // Inicia el compte enrere
    if (fons.num == 0) {
      temps.moviment(); // Carregar el temporitzador
      //Nau
      nau.moviment(); // Metode per controlar el moviment de la nau
      nau.pantalla(); // Metode per dibuixar la nau en pantalla
      // Rectangle que simbolitza l'escut
      if (nau.escut == true) {
        textSize(48);
        noStroke();
        text("ESCUT: ", 350, 50);
        fill(160, 31, 216);
        rect(425, 30, 150, 45);
      } else {
        textSize(48);
        noStroke();
        text("ESCUT: ", 350, 50);
      }
      fill(255);
      text("POTENCIA: " + nau.potencia, 1100, 50);


      // Bala
      for (Bala b : bales) { // Recorrer l'ArrayList
        b.moviment(); // Metode per controlar el moviment de les bales
        b.pantalla(); // Metode per dibuixar la bala en pantalla
      }
      // Potenciador
      if (temps.segons > 05 && temps.segons < 25) { // Cada minut cau un regal pel jugador
        potenciador.millorar = true; // Boolena millorar es tornar true.
        if (temps.segons==20 || temps.segons==22 || temps.segons==24) { // Fa la intermitencia del objecte abans desapareixer.
          potenciador.millorar = false; // Boolena millorar es tornar false.
        }
      } else {
        // Reinicia la posició  i la velocitat del potenciador
        potenciador.posició = new PVector(random(50, width-50), -50); // Posició X
        potenciador.tipusRegal = int(random(1, 5));
        potenciador.velocitat = new PVector(0.0, 2.1); //
        potenciador.millorar = false; // Boolena millorar es tornar false.
      }
      if (potenciador.millorar == true) {
        // Metodes per controlar la classe potenciador
        potenciador.moviment();
        potenciador.pantalla();
      }
      fill(255);
      text("PUNTS: " + punts, 100, 50); //Imprimeix els punts en pantalla
      contadorP ++; // Iniciar el contador per tornar a crear nous enemics un cop eliminats
      if (contadorP == 20) { // Si aquest contador arriba a 20
        if (enemic.size() < maxEnemic ) { // Comprovar el nombre d'enemics en pantalla
          Enemic nouEnemic = new Enemic(new PVector(random(100, width-100), -100), random(60, 80), int(random(1, 15)), new PVector(random(1, 5), random(1, 5))); // Crear un nou enemic
          enemic.add(nouEnemic); // L'afegeix al array
        }
        contadorP = 0; // Posa a 0 el contador
      }
      contadorEnemic++; // Inicia el contador
      if (contadorEnemic == 1500) { // Si el contador arriba a 1500
        maxEnemic++; // augmenta el maxim d'enemics
        contadorEnemic=0; // situa el contador a 0
      }
      // Metodo per controlar l'enemic
      for (Enemic e : enemic) {
        e.moviment(); // Metode per controlar el moviment del enemic
        e.pantalla(); // Metode per dibuixar l'enemic en pantalla
      }
    }
    ColisióNauPotenciador();
    // Control de colisió
    ColisióBalaEnemic(); // Metode per revisar si una Bala de la nau impacta amb un enemic
    ColisióEnemicNau(); // Metode per revisar si un enemic impacta amb la nau

    eliminarBalesForaPantalla();
  }
}

// Comprova la tecla polsada i crida la funció
void keyPressed() {
  nau.teclaPolsada(keyCode); // Crida la funció
}
// Comprova la tecla deixada i crida la funció
void keyReleased() {
  nau.teclaDeixada(keyCode); // Crida la funció
}
// Metode eliminar Bales que surten de la pantalla
void eliminarBalesForaPantalla() {
  ArrayList<Bala> ElimBala = new ArrayList<Bala>(); // ArrayList per guardar les bales que s'han d'eliminar
  for (Bala b : bales) { // Recorrer el ArrayList
    if (b.posició.y <0) { // Comprova la posició Y de cada bala
      ElimBala.add(b); // Afegeix la Bala al arrayList
    }
  }
  bales.removeAll(ElimBala); // Eliminar els registres
}
void ColisióNauPotenciador() {
  float dist =dist(nau.posició.x, nau.posició.y, potenciador.posició.x, potenciador.posició.y);
  if (dist < 60) {
    // Reinicia la posició  i la velocitat del potenciador
    potenciador.posició = new PVector(-100, -50); // Posició X
    switch(potenciador.tipusRegal) {
    case 0:
      nau.potencia = 2;
      efecteInici.rewind();
      efecteInici.play();
      break;
    case 1:
      nau.potencia = 1;
      efecteInici.rewind();
      efecteInici.play();
      break;
    case 2:
      nau.potencia = 3;
      efecteInici.rewind();
      efecteInici.play();
      break;
    case 3:
      nau.potencia = 1;
      efecteInici.rewind();
      efecteInici.play();
      break;
    case 4:
      nau.escut = true;
      efecteEscut.rewind();
      efecteEscut.play();
      break;
    case 5:
      nau.escut = false;
      efecteEscut.rewind();
      efecteEscut.play();
      break;
    }
  }
}
// Metode colision Bala enemic
void ColisióBalaEnemic() {
  ArrayList<Bala> ElimBala = new ArrayList<Bala>(); // ArrayList per guardar les bales a eliminar
  ArrayList<Enemic> ElimEnemic = new ArrayList<Enemic>(); // ArrayList per guardar els enemics a eliminar
  for (Bala b : bales) { // Recorrer el ArrayList
    for (Enemic e : enemic) { // Recorrer el ArrayList
      float dist = dist(b.posició.x, b.posició.y, e.posició.x, e.posició.y);
      if (dist < e.diametre) { // Si la distancia és inferior al diametre del enemic
        if (e.numero > 1) { // Si el numero del enemic és superior a 1
          e.numero = e.numero-1; // Resta 1 al enemic
          punts++;
          ElimBala.add(b); // Afegeix la bala per eliminar
        } else {
          ElimBala.add(b); // Afegeix la bala per eliminar
          ElimEnemic.add(e); // Afegeix el enemic per eliminar
        }
      }
    }
  }
  bales.removeAll(ElimBala); // Elimninar les bales
  enemic.removeAll(ElimEnemic); // Eliminar els enemics
}
void ColisióEnemicNau() {
  for (Enemic e : enemic) { // Recorrer el ArrayList
    float dist = dist(e.posició.x, e.posició.y, nau.posició.x, nau.posició.y);
    if (dist < 80) {
      if (nau.escut == false) {
        resultat = punts; // guarda els punts en la variable resultat
        menu.botoPulsat = false;
        menu.hasperdut = true;
      } else if (nau.escut == true) {
        e.velocitat.y = e.velocitat.y * -0.95; // fa rebotar l'enemic
        e.velocitat.x = e.velocitat.x * -0.95; // fa rebotar l'enemic
        e.numero = e.numero-1; // Resta 1 al enemic
        efecteEscut.play();
        nau.escut = false;
      }
    }
  }
}
void reiniciar() {

  temps.segons = 0; // Posa el temps a 0
  temps.minuts = 0; // posa els minuts a 0
  temps.segons++; // Inicia el comptador
  punts = 0; // Situa els punts a 0
  nau.posició = new PVector(500, 850); // Situa la nau a la posició inicial
  nau.escut = false; // Treu l'escut
  nau.potencia = 1; // Potencia a la posició inicial
  // REinica els enemics
  maxEnemic = 1; // Maxim enemics a 1
  for (Enemic e : enemic) {
    e.posició = new PVector(random(100, width-100), -100); // Posició inicial del enemic
    e.diametre = random(60, 80); // Diametre del enemic
    e.numero = int(random(1, 15)); // Numero del enemic
    e.velocitat = new PVector(random(1, 5), random(1, 5)); // Velocitat del enemic
  }
  enemic.removeAll(enemic); // Eliminar tots els enemcis creats
}
