// Dimensions de la finestra
int amplada = 800;
int altura = 400;

// Variables globals
PVector posJugador; // Posició del jugador
PVector velocitatJugador; // Velocitat del jugador
float gravetat = 0.6; // Gravetat
boolean aTerra = false; // Si el jugador està a terra

// Plataformes
PVector[] plataformes = {
  new PVector(0, 350), 
  new PVector(300, 250), 
  new PVector(600, 300)
};
int ampladaPlataforma = 150;
int alçadaPlataforma = 20;

// Meta
PVector meta = new PVector(750, 330);
int ampladaMeta = 40;
int alçadaMeta = 40;

// Estat del joc
boolean jocFinalitzat = false;
boolean guanyat = false;

// Configura la finestra
void settings() {
    size(amplada, altura); // Mida de la finestra
}

// Configuració inicial
void setup() {
    inicialitzarJoc();
}

// Reinicia totes les variables del joc
void inicialitzarJoc() {
    posJugador = new PVector(50, 300);
    velocitatJugador = new PVector(0, 0);
    jocFinalitzat = false;
    guanyat = false;
}

void draw() {
  background(200, 220, 255); // Cel blau clar

  if (jocFinalitzat) {
    textSize(32);
    fill(guanyat ? color(0, 255, 0) : color(255, 0, 0));
    text(guanyat ? "Has guanyat!" : "Has perdut!", amplada / 2 - 100, altura / 2);

    textSize(16);
    fill(0);
    text("Prem 'R' per tornar a començar", amplada / 2 - 100, altura / 2 + 50);
    return;
  }

  // Actualitzar física i estat del joc
  actualitzarJugador();
  comprovarMeta();

  // Dibuixar elements
  dibuixarJugador();
  dibuixarPlataformes();
  dibuixarMeta();
}

void actualitzarJugador() {
  // Aplicar gravetat
  velocitatJugador.y += gravetat;

  // Moviment horitzontal
  if (keyPressed) {
    if (key == CODED) {
      if (keyCode == LEFT) velocitatJugador.x = -5;
      if (keyCode == RIGHT) velocitatJugador.x = 5;
    }
  } else {
    velocitatJugador.x = 0; // Aturar-se si no es prem res
  }

  // Actualitzar posició
  posJugador.add(velocitatJugador);

  // Limitar el moviment a dins de la pantalla
  posJugador.x = constrain(posJugador.x, 0, amplada);

  // Comprovar col·lisions amb plataformes
  aTerra = false;
  for (PVector plataforma : plataformes) {
    if (colisio(posJugador, 40, 40, plataforma, ampladaPlataforma, alçadaPlataforma)) {
      aTerra = true;
      velocitatJugador.y = 0;
      posJugador.y = plataforma.y - 40; // Ajustar perquè quedi sobre la plataforma
    }
  }

  // Si cau fora de la pantalla, perdre
  if (posJugador.y > altura) {
    jocFinalitzat = true;
    guanyat = false;
  }
}

// Detectar col·lisions entre rectangles
boolean colisio(PVector pos1, int amplada1, int alçada1, PVector pos2, int amplada2, int alçada2) {
  return (pos1.x < pos2.x + amplada2 &&
          pos1.x + amplada1 > pos2.x &&
          pos1.y < pos2.y + alçada2 &&
          pos1.y + alçada1 > pos2.y);
}

void keyPressed() {
  if (jocFinalitzat && key == 'r') {
    inicialitzarJoc(); // Reiniciar el joc
  } else if (key == ' ' && aTerra) {
    velocitatJugador.y = -12; // Força del salt
  }
}

void comprovarMeta() {
  if (colisio(posJugador, 40, 40, meta, ampladaMeta, alçadaMeta)) {
    jocFinalitzat = true;
    guanyat = true;
  }
}

void dibuixarJugador() {
  fill(0, 0, 255); // Blau
  rect(posJugador.x, posJugador.y, 40, 40);
}

void dibuixarPlataformes() {
  fill(100, 200, 100); // Verd
  for (PVector plataforma : plataformes) {
    rect(plataforma.x, plataforma.y, ampladaPlataforma, alçadaPlataforma);
  }
}

void dibuixarMeta() {
  fill(255, 215, 0); // Groc (or)
  rect(meta.x, meta.y, ampladaMeta, alçadaMeta);
}
