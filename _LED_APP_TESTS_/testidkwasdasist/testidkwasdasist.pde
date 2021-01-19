Slider vBrightnessSlider;
color c;
Picker picker;
//picker
boolean debug = false;

void setup() {
  size(400, 500, P2D);
  colorMode(HSB, 360, 100, 100);

  vBrightnessSlider = new Slider(40, 440, 300, 0, 100, 100);
  vBrightnessSlider.id = "Brightness Slider";
  vBrightnessSlider.dotColor = color(255);
  vBrightnessSlider.callback = true;
  vBrightnessSlider.callbackFunction = "updateBrightnessCallback";

  picker = new Picker(200, 250, 200, 50);
  picker.currentColor = color(0);

  c = color(0, 100, 100);
}
int x = 200;
int y = 20;
int hue = 0;
void draw() {

  background(128);

  //  beginShape();

  //  fill(0, 100, 100);
  //  vertex(200, 150);

  //  fill(0);
  //  vertex(145, 300);

  //  fill(255);
  //  vertex(259, 320);

  //  fill(0, 100, 100);
  //  vertex(200, 150);

  //  endShape();

  //  fill(c);
  // ellipse(x, y, 280, 300);
  picker.drawPicker();
  fill(picker.currentColor);
  rect(0, 0, width, 25);
}  

int tArea(int x1, int y1, int x2, int y2, int x3, int y3) {
  return abs(floor((x1 * (y2 - y3) + x2 * (y3 - y1) + x3 * (y1 - y2)) / 2.0));
}

boolean isInside(int x1, int y1, int x2, int y2, int x3, int y3, int mx, int my) {
  float A = tArea(x1, y1, x2, y2, x3, y3); 

  /*Calculate area of triangle PBC */
  float A1 = tArea (mx, my, x2, y2, x3, y3); 

  /*Calculate area of triangle PAC */
  float A2 = tArea(x1, y1, mx, my, x3, y3); 

  /*Calculate area of triangle PAB */
  float A3 = tArea (x1, y1, x2, y2, mx, my); 

  /*Check if sum of A1, A2 and A3 is same as A */
  if (A == A1 + A2 + A3) {
    return true;
  }
  return false;
}

void mousePressed() {
  println("MX: " + mouseX + " MY: " + mouseY + " -> " + isInside(200, 20, 20, 380, 380, 380, mouseX, mouseY));

  if (isInside(200, 20, 20, 380, 380, 380, mouseX, mouseY)) {
    x = floor(mouseX);
    y = floor(mouseY);

    int saturation = abs((x - 40) / 4);
    int brightness = abs((y - 40) / 4);
    //println("S: " + saturation + " B: " + brightness);
    c = color(hue, saturation, brightness);
  }

  if (vBrightnessSlider.isOver()) {
    vBrightnessSlider.lock = true;
  }
}

void mouseDragged() {
  //println("MX: " + mouseX + " MY: " + mouseY);// + " -> " + isInside(200, 20, 20, 380, 380, 380, mouseX, mouseY));

  if (isInside(200, 20, 20, 380, 380, 380, mouseX, mouseY)) {
    x = int(mouseX);
    y = int(mouseY);

    //HSL
    float SL = (100 - map(y, 20, height - 20, 0, 100)) / 100;
    float L = (map(x, 20, width - 20, 0, 100)) / 100;

    //HSV / HSB
    float B = SL * min(L, 1 - L) + L;
    float S = 0;
    if (B!= 0) {
      S = 2 - (2 * L / B);
    }

    //println("HSL: SL: " + SL + " L: " + L + " // HSB: S: " + S + " B: " + B);
    c = color(hue, S * 100, B * 100);
    //println("Color: " + hex(c));
  }
  if (vBrightnessSlider.isOver()) {
    vBrightnessSlider.lock = true;
  }

  float d = dist(picker.x, picker.y, mouseX, mouseY);
  if (100 <  d && d < 150) {         
    picker.select(mouseX, mouseY);
  }
}

void mouseReleased() {
  vBrightnessSlider.unlock();
}
