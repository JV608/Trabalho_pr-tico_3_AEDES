

Bird bird;
ArrayList<Pipe> pipes;
int pipeInterval = 90; // frames entre pipes
int frameCounter = 0;
int score = 0;
boolean gameOver = false;

void setup() {
  size(600, 800);
  frameRate(60);
  resetGame();
}

void resetGame() {
  bird = new Bird(100, height/2);
  pipes = new ArrayList<Pipe>();
  frameCounter = 0;
  score = 0;
  gameOver = false;
}

void draw() {
  background(135, 206, 235); // céu azul

  // gerar pipes em intervalos
  if (!gameOver) {
    frameCounter++;
    if (frameCounter >= pipeInterval) {
      pipes.add(new Pipe(width + 50));
      frameCounter = 0;
    }

    // atualizar e desenhar pipes
    for (int i = pipes.size() - 1; i >= 0; i--) {
      Pipe p = pipes.get(i);
      p.update();
      p.draw();

      // checar colisão
      if (p.hits(bird)) {
        gameOver = true;
      }

      // remover pipes que saíram da tela
      if (p.offscreen()) {
        pipes.remove(i);
        score++;
      }
    }

    // atualizar bird
    bird.update();
    if (bird.offscreen()) {
      gameOver = true;
    }
  }

  // desenhar bird por cima
  bird.draw();

  // HUD
  fill(0);
  textSize(20);
  textAlign(LEFT, TOP);
  text("Score: " + score, 10, 10);
  text("Press SPACE to jump", 10, 35);

  if (gameOver) {
    textAlign(CENTER, CENTER);
    textSize(36);
    fill(255, 0, 0);
    text("GAME OVER", width/2, height/2 - 40);
    textSize(20);
    fill(0);
    text("Press R to restart", width/2, height/2);
    text("Best score nesta rodada: " + score, width/2, height/2 + 30);
  }
}

void keyPressed() {
  if (key == ' ' || key == 'w' || keyCode == UP) {
    if (!gameOver) bird.jump();
  }
  if (key == 'r' || key == 'R') {
    resetGame();
  }
}
