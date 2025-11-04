import gifAnimation.*;

Gif gif;
float x = 0;       // posição inicial
float speed = 2;   // velocidade

void setup() {
  size(800, 400);
  // coloque o GIF dentro da pasta "data" do sketch
  gif = new Gif(this, "jubileu.gif");
  gif.loop(); // toca o GIF em loop (só precisa fazer isso uma vez)
}

void draw() {
  background(200);

  // desenha o GIF em movimento
  image(gif, x, 100, 200, 200);

  // move para frente
  x += speed;

  // quando sai da tela, volta
  if (x > width) {
    x = -200;
  }
}
