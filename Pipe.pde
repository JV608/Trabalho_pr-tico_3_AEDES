
// -------------------- Pipe.pde --------------------
/* Pipe.pde
 * Classe Pipe: controla posição, gap (vão) e detecção de colisão com Bird.
 */

class Pipe {
  float x;
  float w = 80;
  float gapY;     // centro vertical do gap
  float gapHeight = 160;
  float speed = 3.5;

  Pipe(float startX) {
    x = startX;
    // gapY em posição aleatória com margens
    gapY = random(120, height - 120);
  }

  void update() {
    x -= speed;
  }

  void draw() {
    fill(34, 139, 34);
    stroke(0);
    // retângulo superior
    rect(x, 0, w, gapY - gapHeight/2);
    // retângulo inferior
    rect(x, gapY + gapHeight/2, w, height - (gapY + gapHeight/2));

    // desenhar contorno do gap para melhor visual
    noFill();
    stroke(0);
    rect(x, gapY - gapHeight/2, w, gapHeight);
  }

  boolean offscreen() {
    return x + w < 0;
  }

  boolean hits(Bird b) {
    // colisão círculo-retângulo simples: verificar distância mínima do centro do círculo
    // para cada retângulo (superior e inferior). Se menor que radius -> colisão.
    float bx = b.getX();
    float by = b.getY();
    float r = b.getRadius();

    // superior rect
    float rx1 = x;
    float ry1 = 0;
    float rw = w;
    float rh1 = gapY - gapHeight/2;

    // inferior rect
    float rx2 = x;
    float ry2 = gapY + gapHeight/2;
    float rh2 = height - ry2;

    if (circleRectCollision(bx, by, r, rx1, ry1, rw, rh1)) return true;
    if (circleRectCollision(bx, by, r, rx2, ry2, rw, rh2)) return true;
    return false;
  }

  // helper: colisão círculo-retângulo
  boolean circleRectCollision(float cx, float cy, float r, float rx, float ry, float rw, float rh) {
    // encontrar ponto mais próximo no retângulo ao centro do círculo
    float nearestX = max(rx, min(cx, rx + rw));
    float nearestY = max(ry, min(cy, ry + rh));

    float dx = cx - nearestX;
    float dy = cy - nearestY;
    return (dx*dx + dy*dy) <= r*r;
  }
}
