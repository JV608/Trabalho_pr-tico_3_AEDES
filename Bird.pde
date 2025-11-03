
// -------------------- Bird.pde --------------------
/* Bird.pde
 * Classe Bird: posição, física simples (gravidade), desenho e colisão básica.
 */

class Bird {
  float x, y;
  float radius = 18;
  float velocity = 0;
  float gravity = 0.7;
  float jumpForce = -11;

  Bird(float x_, float y_) {
    x = x_;
    y = y_;
  }

  void update() {
    velocity += gravity;
    y += velocity;

    // limitar velocidade terminal
    velocity = constrain(velocity, -15, 15);
  }

  void jump() {
    velocity = jumpForce;
  }

  void draw() {
    pushMatrix();
    translate(x, y);
    // corpo do pássaro
    fill(255, 204, 0);
    stroke(0);
    ellipse(0, 0, radius*2, radius*2);

    // olho simples
    fill(0);
    ellipse(radius*0.25, -radius*0.2, radius*0.35, radius*0.35);

    // bico
    fill(255, 102, 0);
    triangle(radius*0.5, 0, radius*0.5 + 8, -4, radius*0.5 + 8, 4);

    popMatrix();
  }

  // verifica se saiu do topo ou do chão
  boolean offscreen() {
    if (y - radius > height || y + radius < 0) return true;
    return false;
  }

  // retorna bounding circle (usado por Pipe.hits)
  float getX() { return x; }
  float getY() { return y; }
  float getRadius() { return radius; }
}
