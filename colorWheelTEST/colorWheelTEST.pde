void setup() {
  size(500, 500);

  loadPixels();



  updatePixels(); 
  noFill();
  strokeWeight(5);
  colorMode(HSB, 300, 100, 100);
  float increment = PI / 180;
  int radius = 200;
  int brightness = 100;
  for (int j = 0; j < 10; j++) {
    for (float i = 0; i < TWO_PI; i += increment) {
      int h = round(map(i, 0, TWO_PI, 0, 360)); 
        stroke(h, 100, brightness); 
        arc(250, 250, radius, radius, i, i + increment);
    }
    
    radius -= 10;
    brightness -= 9;
  }
  noLoop();
}
void colorWheel(int r) {
  float inc = 0.1; 
    int circles = round(TWO_PI / inc); 
    float colorInc = round(360 / circles); 
    float h = 0; 
    float b = 100; 
    int counter = 0; 
    for (float j = 1; j <= 10; j++) {
    if (j > 1) {
      r -= 20; 
        b -= 10;
    }
    for (float i = 0; i < TWO_PI; i += inc) {
      int x = floor(r * cos(i)); 
        int y = floor(r * sin(i)); 

        colorMode(HSB, 300, 100, 100); 
        fill(h, 100, b); 
        ellipse(x + 200, y + 175, 10, 10); 
        h += colorInc; 
        println("i" + i);
    }
    println(h); 
      h = 0;
  }
}
