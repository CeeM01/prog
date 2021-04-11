int N = 50;
int l = 10;
int[][] estado = new int[N][N];
boolean manual = false;

void setup() {
  size(549, 549);
  background(100);
  noStroke();
  inicia(estado, 1);
  frameRate(5);
}

void draw() {
  background(100);
  if (manual) {
    frameRate(15);
    life(estado, l);
    fill(200, 0, 0);
    rect(20, 20, 40, 40);
  }
  else {
    frameRate(5);
    life(estado, l);
    paso(estado);
  }
}

void life(int[][] estado, int lado) {
  for (int i=0; i<N; i++) {
    for (int j=0; j<N; j++) {
      fill(estado[i][j]*255);
      rect((lado+1)*i, (lado+1)*j, lado, lado);
    }
  }
}

void paso(int[][] estado) {
  int[][] temp = new int[N+2][N+2];
  for (int i=0; i<N; i++) {
    for (int j=0; j<N; j++) {
      temp[i+1][j+1] = estado[i][j];
    }
  }
  for (int i=0; i<N; i++) {
    temp[i+1][0] = estado[i][N-1];
    temp[i+1][N+1] = estado[i][0];
  }
  for (int j=0; j<N; j++) {
    temp[0][j+1] = estado[N-1][j];
    temp[N+1][j+1] = estado[0][j];
  }
  temp[0][0] = estado[N-1][N-1];
  temp[0][N+1] = estado[N-1][0];
  temp[N+1][0] = estado[0][N-1];
  temp[N+1][N+1] = estado[0][0];
  
  int S = 0;
  for (int i=0; i<N; i++) {
    for (int j=0; j<N; j++) {
      S = temp[i][j] + temp[i+1][j] + temp[i+2][j] + temp[i][j+1] + temp[i+2][j+1] + temp[i][j+2] + temp[i+1][j+2] + temp[i+2][j+2]; 
      if (estado[i][j] == 0 && S == 3) {
        estado[i][j] = 1;
      }
      else if (estado[i][j] == 1 && (S < 2 || S > 3)) {
        estado[i][j] = 0;
      }
    }
  }
}

void inicia(int[][] estado, int modo) {
  // modo = 0 -> todo a cero
  // modo = 1 -> aleatorio
  for (int i=0; i<N; i++) {
    for (int j=0; j<N; j++) {
      estado[i][j] = modo*int(random(2));
    }
  }
}

void mousePressed() {
  if (manual) {
    int x = int(mouseX/(l+1));
    int y = int(mouseY/(l+1));
    estado[x][y] = 1-estado[x][y];
  }
}

void keyPressed() {
  if (key == 'v' || key == 'V') {
    inicia(estado, 0);
  }
  else if (key == 'r' || key == 'R') {
    inicia(estado, 1);
  }
  else if (key == 'm' || key == 'M') {
    if (manual) {
      manual = false;
    }
    else {
      manual = true;
    }
  }
}
m
