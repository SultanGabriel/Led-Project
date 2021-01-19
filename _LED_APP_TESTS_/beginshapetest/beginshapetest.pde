void setup() {
  size(500, 500);

}

void draw() {
  background(129);
  fill(0);
  strokeWeight(1);
  //stroke(255);
  //noStroke();
  colorMode(HSB, 360, 100, 100);
  
  beginShape();
  
  float h = 200;
  float w = 200; 
  for(int i = 0; i < 5; i++){
      
  
  }
  
  
  endShape();
  
  noLoop();
}
void colorWheel() {
  int wdh = 50;
  int radius = 150;

  int cx = 250; //CenterX .. CenterY
  int cy = 250;
  float inc = PI / 180;
  float x;
  float y;

  beginShape(TRIANGLE_STRIP);

  for (float i = 0; i <= TWO_PI; i += inc) {
    float h = map(i, 0, TWO_PI, 0, 360);

    fill(h, 100, 100);
    stroke(h, 100, 100);

    x = (radius - wdh) * cos(i) + cx;
    y = (radius - wdh) * sin(i) + cy;
    vertex(x, y);

    x = radius * cos(i) + cx;
    y = radius * sin(i) + cy;
    vertex(x, y);
  }
  //x = radius * cos(inc/2) + cx;
  //y = radius * sin(inc/2) + cy;
  //vertex(x, y);
  //x = (radius - wdh) * cos(0) + cx;
  //y = (radius - wdh) * sin(0) + cy;
  //vertex(x, y);
  endShape();
}

void mousePressed() {
  println(mouseX, mouseY);
}
//vertex(60, 20);
