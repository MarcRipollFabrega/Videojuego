class Menu {
  /**********************************************************Variables****************************************************/
  PVector posicióJugar, dimensióJugar, posicióSortir, dimensióSortir; // Vector per controlar la posició i dimensió del boto
  color colJugar, colSortir; //variable per controlar el color al situar el ratoli sobre el boto
  boolean botoPulsat = false; // Boolean per informar si s'ha polsat el boto
  boolean hasperdut = false; // Boolen per controlar quan el jugador ha perdut

  PImage fonsMenu, exemple; // Variable per carregar les imatges
  //Variables per controlar el registre de punts
  Table table; // Carregar la taula
  int [] regPunts = new int[10]; // Array per guardar els 10 millors resultats
  int cont = 0; // Contador per llegir les dades del Excel


  Menu() {
    fonsMenu = loadImage("fonsMenu.png"); // Carregar el fons del menu
    exemple = loadImage("imatge.jpg"); // Carregar la imatge d'exemple
    /*****************************************************boto Jugar********************************************************/
    posicióJugar = new PVector(200, height/2+80); // Posició del boto
    dimensióJugar= new PVector(120, 60); // Dimensió del boto
    colJugar = color(0); // color inicial
    /*****************************************************boto Sortir********************************************************/
    posicióSortir = new PVector(width-300, height/2+80); // Posició del boto
    dimensióSortir= new PVector(120, 60); // Dimensió del boto
    colSortir = color(0); // color inicial
    lecturaTaula();
  }
  void pantalla() {

    image(fonsMenu, width/2, height/2); // Situa la imatge
    image(exemple, width/2, height/2-200, 750, 527); // Situa la imatge
    if (hasperdut==true) {
      stroke(255); // Color de les linies
      fill(255); // Color de fons
      textAlign(CENTER, CENTER); // Centra el text
      textSize(60); // mida del text
      text("HAS PERDUT!!! punts: " + resultat, width/2, (height/2)+80); // Text
      reiniciar(); // Reinicia el joc
      lecturaTaula(); // Llegeix la taula
    }
    /*****************************************************boto Jugar********************************************************/
    strokeWeight(5); // Gruix de les linies
    stroke(colJugar); // Color de les linies
    fill(244, 245, 20); // Color de fons
    rect(posicióJugar.x, posicióJugar.y, dimensióJugar.x, dimensióJugar.y, 28); // rectangle boto
    fill(0); // color text
    textAlign(CENTER, CENTER); // Centra el text
    textSize(30); // mida del text
    text("JUGAR", posicióJugar.x+(dimensióJugar.x/2), posicióJugar.y+(dimensióJugar.y/2)); // Text
    /*****************************************************boto Sortir********************************************************/
    strokeWeight(5); // Gruix de les linies
    stroke(colSortir); // Color de les linies
    fill(244, 245, 20); // Color de fons
    rect(posicióSortir.x, posicióSortir.y, dimensióSortir.x, dimensióSortir.y, 28); // rectangle boto
    fill(0); // color text
    textAlign(CENTER, CENTER); // Centra el text
    textSize(30); // mida del text
    text("Sortir", posicióSortir.x+(dimensióSortir.x/2), posicióSortir.y+(dimensióSortir.y/2)); // Text
    /*****************************************************registres**************************************************************/

    strokeWeight(6); // Gruix de les lines
    stroke(#6DBFEA); // color de les linies
    fill(#1499DE); // color de fons
    rect(150, 650, 1080, 290); //Rectangle principal
    stroke(0); // Color negre la linia
    noFill(); // No emplena
    rect(145, 645, 1090, 300); // Rectangle sombra
    textAlign(CORNER); // Alineació text
    textSize(55);
    fill(255); // Color del text
    text("RANKING", 550, 700);
    textSize(45); // Mida del text
    // Dibuixem cada un dels registres
    text(" 1 posició: " + regPunts[0] + " punts", 150, 730);
    text(" 2 posició: " + regPunts[1] + " punts", 150, 780);
    text(" 3 posició: " + regPunts[2] + " punts", 150, 830);
    text(" 4 posició: " + regPunts[3] + " punts", 150, 880);
    text(" 5 posició: " + regPunts[4] + " punts", 150, 930);
    text(" 6 posició: " + regPunts[5] + " punts", 760, 730);
    text(" 7 posició: " + regPunts[6] + " punts", 760, 780);
    text(" 8 posició: " + regPunts[7] + " punts", 760, 830);
    text(" 9 posició: " + regPunts[8] + " punts", 760, 880);
    text("10 posició: " + regPunts[9] + " punts", 760, 930);
  }
  void moviment() {
    /*****************************************************boto Jugar********************************************************/
    //Si el ratoli está a sobre el boto
    if (mouseX > posicióJugar.x && mouseX < posicióJugar.x+dimensióJugar.x &&
      mouseY > posicióJugar.y && mouseY < posicióJugar.y+dimensióJugar.y) {

      colJugar = color(255, 0, 0); // Modificar el color de les linies
      if (mousePressed) { // Si s'ha polsat el boto
        botoPulsat = true; // boto polsat
        menu.hasperdut = false;
        efecteInici.rewind();
        efecteInici.play();
      }
    } else {
      colJugar = color(0); // Color per defecte
    }
    /*****************************************************boto Sortir********************************************************/
    //Si el ratoli está a sobre el boto
    if (mouseX > posicióSortir.x && mouseX < posicióSortir.x+dimensióSortir.x &&
      mouseY > posicióSortir.y && mouseY < posicióSortir.y+dimensióSortir.y) {

      colSortir = color(255, 0, 0); // Modificar el color de les linies
      if (mousePressed) { // Si s'ha polsat el boto
        efecteInici.rewind();
        efecteInici.play();
        exit();
      }
    } else {
      colSortir = color(0); // Color per defecte
    }
  }
  void lecturaTaula() {
    // Carrega la taula de registres
    table = loadTable("data/registre.csv", "header");
    for (TableRow row : table.rows()) {
      regPunts[cont] = row.getInt("punts"); // Guardar cada un dels registres en l'array
      if (cont < 9) { // Impedeix que el cont superi el valor maxim del array
        cont++; // Suma 1 al comptador
      }
    }
    // Comprova la variable resultat i guardar el nou registre en la posició adecuada
    if (resultat>0 && hasperdut==true) { // Si resultat és superior a 0, és a dir que s'ha jugat una partida
      if (resultat > regPunts[9] && resultat < regPunts[8]) {
        regPunts = splice(regPunts, resultat, 9); // Incorpora el resultat al array
      }
      if (resultat > regPunts[8] && resultat < regPunts[7]) {
        regPunts = splice(regPunts, resultat, 8); // Incorpora el resultat al array
      }
      if (resultat > regPunts[7] && resultat < regPunts[6]) {
        regPunts = splice(regPunts, resultat, 7); // Incorpora el resultat al array
      }
      if (resultat > regPunts[6] && resultat < regPunts[5]) {
        regPunts = splice(regPunts, resultat, 6); // Incorpora el resultat al array
      }
      if (resultat > regPunts[5] && resultat < regPunts[4]) {
        regPunts = splice(regPunts, resultat, 5); // Incorpora el resultat al array
      }
      if (resultat > regPunts[4] && resultat < regPunts[3]) {
        regPunts = splice(regPunts, resultat, 4); // Incorpora el resultat al array
      }
      if (resultat > regPunts[3] && resultat < regPunts[2]) {
        regPunts = splice(regPunts, resultat, 3); // Incorpora el resultat al array
      }
      if (resultat > regPunts[2] && resultat < regPunts[1]) {
        regPunts = splice(regPunts, resultat, 2); // Incorpora el resultat al array
      }
      if (resultat > regPunts[1] && resultat < regPunts[0]) {
        regPunts = splice(regPunts, resultat, 1); // Incorpora el resultat al array
      }
      if (resultat > regPunts[0]) {
        regPunts = splice(regPunts, resultat, 0); // Incorpora el resultat al array
      }

      salvarTaula();
    }
  }
  // Guardem la taula amb els resultats del Array
  void salvarTaula() {
    table = new Table();
    table.addColumn("punts");
    TableRow newRow = table.addRow();
    newRow.setInt("punts", regPunts[0]);
    table.addRow(newRow);
    newRow.setInt("punts", regPunts[1]);
    table.addRow(newRow);
    newRow.setInt("punts", regPunts[2]);
    table.addRow(newRow);
    newRow.setInt("punts", regPunts[3]);
    table.addRow(newRow);
    newRow.setInt("punts", regPunts[4]);
    table.addRow(newRow);
    newRow.setInt("punts", regPunts[5]);
    table.addRow(newRow);
    newRow.setInt("punts", regPunts[6]);
    table.addRow(newRow);
    newRow.setInt("punts", regPunts[7]);
    table.addRow(newRow);
    newRow.setInt("punts", regPunts[8]);
    table.addRow(newRow);
    newRow.setInt("punts", regPunts[9]);
    saveTable(table, "data/registe.csv");
  }
}
