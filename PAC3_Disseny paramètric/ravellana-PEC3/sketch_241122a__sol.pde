// PEC3 - Disseny d'un model dinàmic
// Aquest sketch representa un sol dinàmic amb un cercle central i rajos. Les dimensions i colors
// del sol es poden modificar amb el ratolí i el teclat per experimentar amb el model gràfic.

// Variables globals del model
float radiSol = 100;        // Radi del cercle central (sol)
float longitudRajos = 50;   // Longitud dels rajos solars
color colorSol;             // Color del sol i els rajos
float angleRotacio = 0;     // Rotació dels rajos (per animació)

// Configuració inicial
void setup() {
  size(600, 600);
  colorSol = color(255, 204, 0); // Color inicial groc
}

// Dibuixa l'escena
void draw() {
  background(135, 206, 250); // Blau cel
  
  translate(width / 2, height / 2); // Centrem el sol
  
  // Dibuix del sol
  dibuixarSol(radiSol, longitudRajos, colorSol, angleRotacio);
}

// Funció per dibuixar el sol
void dibuixarSol(float radi, float longitud, color c, float angle) {
  noStroke();
  fill(c);
  ellipse(0, 0, radi * 2, radi * 2); // Dibuixa el cercle central

  // Dibuix dels rajos
  stroke(c);
  strokeWeight(3);
  for (int i = 0; i < 12; i++) {
    float x1 = cos(TWO_PI / 12 * i + angle) * radi;
    float y1 = sin(TWO_PI / 12 * i + angle) * radi;
    float x2 = cos(TWO_PI / 12 * i + angle) * (radi + longitud);
    float y2 = sin(TWO_PI / 12 * i + angle) * (radi + longitud);
    line(x1, y1, x2, y2);
  }
}

// Interacció amb el ratolí
void mouseMoved() {
  // El moviment del ratolí horitzontal ajusta el radi del sol
  radiSol = map(mouseX, 0, width, 50, 200);
  
  // El moviment del ratolí vertical ajusta la longitud dels rajos
  longitudRajos = map(mouseY, 0, height, 20, 100);
}

// Interacció amb el teclat
void keyPressed() {
  if (key == 'c' || key == 'C') {
    // Canvia el color del sol i dels rajos aleatòriament
    colorSol = color(random(255), random(255), random(255));
  } else if (key == 'r' || key == 'R') {
    // Reinicia les dimensions del sol
    radiSol = 100;
    longitudRajos = 50;
    colorSol = color(255, 204, 0); // Groc inicial
    angleRotacio = 0;
  } else if (key == 't' || key == 'T') {
    // Activa l'animació de rotació dels rajos
    angleRotacio += radians(5);
  }
}
