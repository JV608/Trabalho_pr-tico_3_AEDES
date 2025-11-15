
import gifAnimation.*;
PImage fundo;
Gif gif;

Population population;
ArrayList<Pipe> pipes;
int pipeInterval = 100;
int frameCounter = 0;

void setup() {
  size(650, 455);
  pipes = new ArrayList<Pipe>();
  population = new Population(200, 0.2);
  fundo = loadImage("https://raw.githubusercontent.com/JV608/Trabalho_pr-tico_3_AEDES/refs/heads/main/db632b2b01b3be6241f9ee6ab7ff9130.jpg");
  gif = new Gif(this, "https://raw.githubusercontent.com/JV608/Trabalho_pr-tico_3_AEDES/refs/heads/main/passaro.gif");
  gif.loop(); 

}

void draw() {
  background(fundo);

  // adiciona canos periodicamente
  if (frameCounter % pipeInterval == 0) {
    pipes.add(new Pipe());
  }
  frameCounter++;

  // atualiza e desenha canos
  for (int i = pipes.size() - 1; i >= 0; i--) {
    Pipe p = pipes.get(i);
    p.update();
    p.draw();
    if (p.x + p.w < 0) pipes.remove(i);
  }

  // atualiza e desenha população
  population.update(pipes);
  population.draw();

  // se todos morreram, evolui
  if (population.allDead()) {
    population.evolve();
    pipes.clear();
    frameCounter = 0;
    population.resetPositions();
  }

  // HUD
  fill(255);
  textSize(16);
  text("Geração: " + population.ga.generation, 10, 20);
  text("Melhor Score: " + population.ga.bestScore, 10, 40);
}
