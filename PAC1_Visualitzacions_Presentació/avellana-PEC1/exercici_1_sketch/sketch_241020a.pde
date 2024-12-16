// Exemple de variables que es poden personalitzar
boolean ilusion = true; // Canvia a 'false' si no comences el curs amb il·lusió
boolean masLetras = true; // Si prefereixes lletres en lloc de números
boolean etiquetas = false; // Si no creus en les etiquetes
boolean dia = true; // Si prefereixes el dia en lloc de la nit
boolean curiosidad = true; // Si la programació creativa et causa curiositat
boolean extravertido = true; // Si ets extravertit
int tareas = 5; // Nombre de tasques que fas al dia
int amigos = 3; // Nombre d'amics o familiars que veus al dia
boolean optimista = true; // Si veus el got mig ple
boolean sentirseViejo = false; // Si et sents més jove

// Variables per a la interactivitat
color colorCabeza = color(255, 200, 200);
color colorOjos = color(0);
color colorBoca = color(255, 100, 100);

void setup() {
    size(600, 600); // Configuració de la mida del llenç
    noStroke(); // Elimina el contorn per defecte
}

void draw() {
    background(220); // Color de fons

    // Dibuixar la lletra "R" en la cantonada superior esquerra
    fill(0, 0, 255); // Color blau
    textSize(32);
    textAlign(LEFT, TOP);
    text('R', 40, 30); // Posició ajustada perquè no quedi tapada

    // 1. Dibuixar el contorn del cap
    strokeWeight(ilusion ? 5 : 1); // Línia gruixuda si comences amb il·lusió
    fill(colorCabeza);
    if (masLetras) {
        // Cap rodó si ets més de lletres
        ellipse(300, 300, 200, 200);
    } else {
        // Cap quadrat si ets més de números, rotat si no creus en etiquetes
        if (etiquetas) {
            rect(200, 200, 200, 200);
        } else {
            pushMatrix();
            translate(300, 300);
            rotate(PI / 4);
            rect(-100, -100, 200, 200);
            popMatrix();
        }
    }

    // 2. Dibuixar un cercle en una cantonada
    fill(dia ? color(255, 204, 0) : color(128)); // Groc per al dia, gris per a la nit
    ellipse(50, 50, 50, 50);

    // 3. Dibuixar els ulls
    fill(colorOjos);
    int eyeSize = curiosidad ? 40 : 20; // Ulls grans si tens curiositat, petits si no
    ellipse(260, 270, eyeSize, eyeSize);
    ellipse(340, 270, eyeSize, eyeSize);

    // 4. Dibuixar la boca
    fill(colorBoca);
    int mouthWidth = extravertido ? 100 : 50; // Boca gran si ets extravertit, petita si ets tímid
    arc(300, 350, mouthWidth, 50, 0, PI);

    // 5. Dibuixar punts per a cada tasca diària
    fill(0);
    for (int i = 0; i < tareas; i++) {
        ellipse(50 + i * 20, 550, 10, 10);
    }

    // 6. Dibuixar quadrats petits per a cada amic o familiar
    for (int i = 0; i < amigos; i++) {
        rect(550, 50 + i * 20, 10, 10);
    }

    // 7. Dibuixar el triangle (got mig ple o buit)
    fill(0, 153, 153);
    if (optimista) {
        triangle(300, 100, 280, 140, 320, 140); // Triangle apuntant cap amunt
    } else {
        triangle(300, 140, 280, 100, 320, 100); // Triangle apuntant cap avall
    }

    // Dibuixar una "R" petita a la cantonada inferior dreta
    fill(0, 0, 255);
    textSize(16);
    textAlign(RIGHT, BOTTOM);
    text('R', 580, 580); // Posició ajustada perquè es vegi bé
}

// Canviar colors en fer clic
void mousePressed() {
    colorCabeza = color(random(255), random(255), random(255));
    colorOjos = color(random(255), random(255), random(255));
    colorBoca = color(random(255), random(255), random(255));
}
