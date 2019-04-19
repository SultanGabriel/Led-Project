//  <<<--->>> <<<--->>> <<<--->>> <<<--->>>
int segs = 12;
int steps = 16;
float rotAdjust = TWO_PI / segs / 2;
float radius;
float segWidth;
float interval = TWO_PI / segs;

int sizeX; 
int sizeY;

void shadeWheelSETUP(int sizeX_, int sizeY_) {
  sizeX = sizeX_;
  sizeY = sizeY_;
  smooth();
  ellipseMode(RADIUS);

  radius = min(sizeX, sizeY) * 0.45;
  segWidth = radius / steps;
}

void drawShadeWheel() {
  //background(255);

  for (int j = 0; j < steps; j++) {
    color[] cols = {
      color(255-(255/steps)*j, 255-(255/steps)*j, 0), 
      color(255-(255/steps)*j, (255/1.5)-((255/1.5)/steps)*j, 0), 
      color(255-(255/steps)*j, (255/2)-((255/2)/steps)*j, 0), 
      color(255-(255/steps)*j, (255/2.5)-((255/2.5)/steps)*j, 0), 

      color(255-(255/steps)*j, 0, 0), // red
      color(255-(255/steps)*j, 0, (255/2)-((255/2)/steps)*j), 
      color(255-(255/steps)*j, 0, 255-(255/steps)*j), 
      color((255/2)-((255/2)/steps)*j, 0, 255-(255/steps)*j), 

      color(0, 0, 255-(255/steps)*j), //blue
      color(0, 255-(255/steps)*j, (255/2.5)-((255/2.5)/steps)*j), 

      color(0, 255-(255/steps)*j, 0), //green
      color((255/2)-((255/2)/steps)*j, 255-(255/steps)*j, 0)
    };
    noStroke();
    for (int i = 0; i < segs; i++) {
      /*fill(255);
       ellipse(sizeX/2, sizeY/2, radius + segWidth, radius + segWidth);*/
      fill(cols[i]);
      arc(sizeX/2 + 25, height - sizeY/2 - 25, radius, radius, 
        interval*i+rotAdjust, interval*(i+1)+rotAdjust);
      /*fill(0);
       ellipse(sizeX/2, sizeY/2, segWidth, segWidth);*/
    }
    radius -= segWidth;
  }
}
