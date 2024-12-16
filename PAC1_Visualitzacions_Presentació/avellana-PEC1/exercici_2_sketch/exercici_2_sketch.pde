// ----------------------------------------
// Visualització de dades: Cafès i Hores de Son
// Aquest sketch mostra el nombre de cafès consumits cada dia d'una setmana
// i les hores de son en format gràfic. Cada barra representa els cafès i cada
// cercle representa les hores de son. A més, els colors de les barres i cercles 
// canvien per fer la visualització més interessant.
// ----------------------------------------

Table dades; // Taula per carregar les dades
int[] cafes;
int[] horesDeSon;
String[] dies;

void setup() {
  size(1440, 900); // Dimensions màximes per complir el requisit
  background(240); // Color de fons neutre
  
  // Carregar les dades del fitxer CSV
  dades = loadTable("dades.csv", "header");
  
  // Inicialitzar els arrays per emmagatzemar les dades
  cafes = new int[dades.getRowCount()];
  horesDeSon = new int[dades.getRowCount()];
  dies = new String[dades.getRowCount()];
  
  // Llegir les dades del fitxer CSV
  for (int i = 0; i < dades.getRowCount(); i++) {
    TableRow row = dades.getRow(i);
    dies[i] = row.getString("Dia");
    cafes[i] = row.getInt("Cafes");
    horesDeSon[i] = row.getInt("HoresDeSon");
  }
  
  // Visualitzar les dades
  visualitzarDades();
}

void visualitzarDades() {
  // Variables de configuració gràfica
  int marge = 100;
  int ampleBarra = (width - 2 * marge) / cafes.length;
  
  // Dibuixar les barres i els cercles
  for (int i = 0; i < cafes.length; i++) {
    // Posició x de cada dia
    int x = marge + i * ampleBarra;
    
    // Dibuixar les barres per representar els cafès
    fill(100 + i * 20, 150, 200 - i * 20); // Colors dinàmics per cada dia
    rect(x, height - marge - cafes[i] * 30, ampleBarra - 10, cafes[i] * 30);
    
    // Dibuixar els cercles per representar les hores de son
    fill(200, 100 + i * 20, 150);
    ellipse(x + ampleBarra / 2, height - marge - cafes[i] * 30 - horesDeSon[i] * 10, 30, 30);
    
    // Etiquetar els dies
    fill(0);
    textAlign(CENTER);
    text(dies[i], x + ampleBarra / 2, height - 50);
  }
}
