void setup() {
  size(500, 500);
}

void draw() {
  float inc = PI / 180;
  float radius = 200;
  noStroke();
  colorMode(HSB, 360);
  for (float i = 0; i < TWO_PI; i += inc) {
    int h = round(map(i, 0, TWO_PI, 0, 360));
    fill(h, 100, 100);
    arc(250, 250, radius, radius, i, i + inc);
  }
  //cx = round(( radius ) / 2 * cos(radians(currentHue)) + x);
  //cy = round(( radius ) / 2 * sin(radians(currentHue)) + y);

  //stroke(0);
  //strokeWeight(5);
  //line(x, y, cx, cy);

  //strokeWeight(2);
  //fill(hue);
  //ellipse(x, y, 50, 50);
  //triangle();

  //ellipse(cx, cy, w * 2, w * 2);

  //rect(mouseX - 10, mouseY - 10, 20, 20, 25);
}


void mousePressed() {
  println(mouseX, mouseY);
}

void colorSquare() {
  noStroke();
  colorMode(HSB, 360, 100, 100);
  for (int i = 0; i < 80; i++) {
    for (int j = 50; j >= 0; j--) {
      fill(i * 4.5, 100 - j * 2, j * 5);
      rect(i * 5, height - j * 5, 5, 5);
    }
  }
}

void drawColorCircleUsingPixels() {
  loadPixels();

  colorMode(HSB, 360, 100, 100);
  strokeWeight(2);

  float inc = PI / 360;

  for (float phi = 0; phi < TWO_PI; phi+=inc) {

    float xOffset = 250;
    float yOffset = 250;

    float r = 200;

    float x1 = floor(r * cos(phi)) + xOffset;
    float y1 = floor(r * sin(phi)) + yOffset;

    float x2 = floor((r-40) * cos(phi)) + xOffset;
    float y2 = floor((r-40) * sin(phi)) + yOffset;

    println(x1, x2);

    float h = phi / TWO_PI * 360;

    for (int i = 0; i < 50; i++) {

      float x = floor((r-i) * cos(phi)) + xOffset;
      float y = floor((r-i) * sin(phi)) + yOffset;

      int p = floor(y * width + x);//pixel

      pixels[p] = color(h, 100, 100);
      pixels[p+1] = color(h, 100, 100);
      //pixels[p-1] = color(h, 100, 100);
      pixels[p+width] = color(h, 100, 100);
      //pixels[p-width] = color(h, 100, 100);
    }

    fill(h, 100, 100);
    noStroke();
    //ellipse(x1, y1, 25, 25);
    //text(h, x2,y2);

    //stroke(h, 100, 100);
    //line(x1, y1, x2, y2);
  }
  updatePixels();
  noLoop();
}
