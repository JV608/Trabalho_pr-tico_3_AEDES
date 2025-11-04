class Pipe {
  float x;
  float gapY;
  float gapHeight;
  float w;
  float speed;

  Pipe() {
    w = 60;
    gapHeight = 150;
    gapY = random(gapHeight / 2, height - gapHeight / 2);
    x = width + 50; // começa fora da tela, à direita
    speed = 3;
  }

  void update() {
    x -= speed;
  }

  void draw() {
    fill(0, 200, 0);
    noStroke();
    rect(x, 0, w, gapY - gapHeight / 2);
    rect(x, gapY + gapHeight / 2, w, height - (gapY + gapHeight / 2));
  }

  boolean collides(Bird b) {
    // colisão AABB simples com tolerância baseada no raio do pássaro
    float halfSize = 10;
    if (b.x + halfSize > x && b.x - halfSize < x + w) {
      if (b.y - halfSize < gapY - gapHeight / 2 || b.y + halfSize > gapY + gapHeight / 2) {
        return true;
      }
    }
    return false;
  }
}
