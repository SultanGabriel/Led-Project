import http.requests.*;

//D3 RED D6 GREEN D11 BLUE
String link = "http://blynk-cloud.com/df45bf3e324b41929d3eb505832f2d82/update/";//D3?value=150"
//GetRequest get = new GetRequest();
//get.send();
Picker picker;
//0053
void setup() {
  size(500, 300);
  noStroke();
  picker = new Picker(250, 150, 200);
}

void draw() {
  colorMode(HSB, 360, 100, 100);
  background(255);
  picker.drawPicker();
}
GetRequest get;
void mousePressed() {
  picker.select(mouseX, mouseY);
}
void send(color c) {
  get = new GetRequest(link + "D3?value=" + red(c));
  get.send();
  get = new GetRequest(link + "D6?value=" + green(c));
  get.send();
  get = new GetRequest(link + "D11?value=" + blue(c));
  get.send();
}


class Picker {
  float x;
  float y;
  float radius;
  float w = 15;
  float increment = PI / 180;
  float currentHue = -75;
  color currentColor;

  float angle = 0;

  Picker(float _x, float _y, float _radius) {
    x = _x;
    y = _y;
    radius = _radius;
  }

  void select(int mX, int mY) {
    //    int mX = mouseX;
    //    int mY = mouseY;

    currentColor = get(mX, mY);
    currentHue = hue(currentColor);

    angle = degrees(atan(mY/mX));
    println(angle);
    send(currentColor);
  }

  void update() {
    println(currentHue);
    currentHue = currentHue % 360;
    currentHue = abs(currentHue);
    currentColor = color(currentHue, 100, 100);
  }

  void drawPicker() {
    noFill();
    strokeWeight(w);
    colorMode(HSB, 360, 100, 100);

    for (float i = 0; i < TWO_PI; i += increment) {
      int h = round(map(i, 0, TWO_PI, 0, 360));
      stroke(h, 100, 100);
      arc(x, y, radius, radius, i, i + increment);
    }

    float cy = ( radius ) / 2 * sin(radians(currentHue)) + y;
    float cx = ( radius ) / 2 * cos(radians(currentHue)) + x;

    stroke(0);
    strokeWeight(5);

    line(x, y, cx, cy);

    strokeWeight(2);

    fill(currentHue, 100, 100);

    ellipse(x, y, 50, 50);
    //triangle();

    ellipse(cx, cy, 30, 30);

    //rect(mouseX - 10, mouseY - 10, 20, 20, 25);
  }
}
