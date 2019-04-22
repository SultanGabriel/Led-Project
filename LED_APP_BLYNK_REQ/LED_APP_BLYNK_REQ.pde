import http.requests.*;
import ddf.minim.*;
import javax.sound.sampled.*;

AudioInput player;
Minim minim;
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
  minim = new Minim(this);
  getMixer();
  player = minim.getLineIn();
}

void draw() {
  colorMode(HSB, 360, 100, 100);
  background(255);
  picker.drawPicker();
  send(musicOneColor(color(0, 100, 100)));
}

GetRequest get;
void mousePressed() {
  picker.select(mouseX, mouseY);
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

int max = 1974;
color musicOneColor(color clr) {
  int count = 0;
  float soundIn;
  int lowTot = 0;
  int s, h, br;

  for (int i = 0; i < player.left.size()/2.0; i+=5) {
    soundIn = abs(( player.left.get(i) + player.right.get(i))/2);
    lowTot+= ( soundIn * 20 );
    count++;
  }

  colorMode(HSB, 360, 100, 100);

  s = int(saturation(clr));
  h = int(hue(clr));
  br = int(map(lowTot, 0, count * 20, 0, 100));

  return color(h, s, br);
}

void getMixer() {
  Mixer.Info[] mixerInfo = AudioSystem.getMixerInfo();
  for (Mixer.Info m : mixerInfo) {
    String name = m.getName();
    if (name.contains("Stereomix")) {
      minim.setInputMixer(AudioSystem.getMixer(m));
      break;
    }
  }
}
