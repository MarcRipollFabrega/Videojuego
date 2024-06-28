class Temporitzador {

  int inicitemporitzador;  // Variable temporitzador
  int interval; // Interval per calcular els segons (milesimes/1000);
  int segons, minuts; // variables pels segons i minuts
  String s; // String per guardar el temps


  Temporitzador(int timeInterval) {
    interval = timeInterval; // Asignar el valor del constructor a la variable
  }
  void start() {
    inicitemporitzador= millis();  // Inicia el comptador
    segons++; // Iniciar els segons
    if (segons == 60) { // Cada 60 segons
      minuts++; // Suma 1 minut
      segons = 00; // Situa a 0 els segons
    }
  }
  boolean complet() {
    int elapsedTime = millis() - inicitemporitzador; //Temps transcorregut
    if (elapsedTime > interval) { // si ha passat un segon
      return true; // Retorna true
    } else {
      return false; // retorna false
    }
  }
  void moviment() {
    if (complet() == true) { // Si complet és true
      start(); // Iniciar el temporitzador
    }
    fill(255);
    textSize(48);
    textAlign(CENTER,CENTER);
    s =  nf(minuts, 2) + ":" + nf(segons, 2);
    text(s, width/2, 50);
  }
}
