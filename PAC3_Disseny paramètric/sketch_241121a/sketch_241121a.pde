// Classe per guardar les propietats d'un ós
class Os {
  float costat; // Mida de l'ós
  float x, y;   // Posició de l'ós
  color colorPell, colorOrella; // Colors
  float angle;  // Rotació

  // Constructor
  Os(float _costat, float _x, float _y, color _colorPell, color _colorOrella) {
    costat = _costat;
    x = _x;
    y = _y;
    colorPell = _colorPell;
    colorOrella = _colorOrella;
    angle = random(0, TWO_PI); // Rotació inicial aleatòria
  }

  // Actualitza la rotació
  void rotar(float increment) {
    angle += increment;
  }
}

// Array de óssos
Os[] ossos;
int files = 4;    // Nombre de files
int columnes = 4; // Nombre de columnes

// Variables globals per controlar proporcions i interactivitat
float fPupilla = 0.5;  // Proporció pupil·la / ull
float fOrella = 0.5;   // Proporció orella petita / gran
float fBocaY = 0.25;   // Posició vertical de la boca

void setup() {
  size(600, 600);
  background(200, 220, 255);

  // Inicialitzem els óssos
  inicialitzarOssos();
}

void draw() {
  background(200, 220, 255);

  // Dibuixem cada ós
  for (int i = 0; i < ossos.length; i++) {
    Os o = ossos[i];
    pushMatrix();
    translate(o.x, o.y);
    rotate(o.angle); // Aplicar rotació
    dibuixarOs(o.costat, 0, 0, o.colorPell, o.colorOrella);
    popMatrix();
  }
}

void dibuixarOs(float _costat, float _px, float _py, color _colorPell, color _colorOrella) {
  // Càlcul de dimensions
  float diamNas = _costat / 4;
  float diamBoca = _costat / 8;
  float diamUII = _costat / 8;
  float diamPupilla = diamUII * fPupilla; // Variable global fPupilla
  float diamOrella = _costat / 4;
  float diamOrellaInt = diamOrella * fOrella; // Variable global fOrella

  pushMatrix();
  translate(_px, _py);
  
  // Pell (cercle principal)
  fill(_colorPell);
  noStroke();
  ellipse(0, 0, _costat, _costat);

  // Nas
  fill(0); // Negre
  ellipse(0, 0, diamNas, diamNas);

  // Boca
  ellipse(0, _costat * fBocaY, diamBoca, diamBoca);

  // Ulls
  fill(255); // Blanc de l'ull
  ellipse(-_costat / 4, -_costat / 4, diamUII, diamUII);
  ellipse(_costat / 4, -_costat / 4, diamUII, diamUII);

  fill(0); // Pupilles
  ellipse(-_costat / 4, -_costat / 4, diamPupilla, diamPupilla);
  ellipse(_costat / 4, -_costat / 4, diamPupilla, diamPupilla);

  // Orelles
  fill(_colorOrella);
  ellipse(-_costat * 3 / 8, -_costat * 3 / 8, diamOrella, diamOrella);
  ellipse(_costat * 3 / 8, -_costat * 3 / 8, diamOrella, diamOrella);

  fill(_colorPell); // Interior orella
  ellipse(-_costat * 3 / 8, -_costat * 3 / 8, diamOrellaInt, diamOrellaInt);
  ellipse(_costat * 3 / 8, -_costat * 3 / 8, diamOrellaInt, diamOrellaInt);

  popMatrix();
}

// Funció per inicialitzar els óssos
void inicialitzarOssos() {
  ossos = new Os[files * columnes];
  
  int index = 0;
  for (int i = 0; i < files; i++) {
    for (int j = 0; j < columnes; j++) {
      // Generem propietats aleatòries
      float mida = random(50, 150);
      float x = width / columnes * j + width / columnes / 2;
      float y = height / files * i + height / files / 2;
      color colorPell = color(random(200, 255), random(100, 200), random(150, 250));
      color colorOrella = color(random(100, 255), random(50, 150), random(50, 100));

      // Creem un nou ós i el guardem a la llista
      ossos[index] = new Os(mida, x, y, colorPell, colorOrella);
      index++;
    }
  }
}

// Interacció amb el ratolí
void mousePressed() {
  // Canvia colors de tots els óssos
  for (int i = 0; i < ossos.length; i++) {
    ossos[i].colorPell = color(random(200, 255), random(100, 200), random(150, 250));
    ossos[i].colorOrella = color(random(100, 255), random(50, 150), random(50, 100));
  }
}

// Interacció amb el teclat
void keyPressed() {
  if (key == 'r' || key == 'R') {
    // Reinicia els óssos
    inicialitzarOssos();
  } else if (key == 't' || key == 'T') {
    // Augmenta la rotació de tots els óssos
    for (int i = 0; i < ossos.length; i++) {
      ossos[i].rotar(PI / 8); // Rotació de 22.5 graus
    }
  }
}

// Mapeja el moviment del ratolí per modificar variables globals
void mouseMoved() {
  fPupilla = map(mouseX, 0, width, 0.1, 1.0);  // Mida pupil·la
  fOrella = map(mouseY, 0, height, 0.1, 1.0); // Proporció orella
}
