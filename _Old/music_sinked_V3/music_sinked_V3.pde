import ddf.minim.*;
import processing.serial.*;

Serial ard;
AudioInput player;
Minim minim;

void setup() {
  size(100, 100);
  surface.setResizable(true);
  colorMode(RGB);

  minim = new Minim(this);
  player = minim.getLineIn();

  connectToArd("COM3");
  background(255);
}
boolean musicSinced = false;
color c;
color clr = color(255, 0, 0);
int r, g, b;
int sel = 0;
void draw() {
  if (ard.read() == 'M') {
    musicSinced = !musicSinced;
    println("M");
  }

  if (musicSinced) {
    c = musicOneColor(clr);
    if (sel == 0) {
      r = int(red(c));
    } else if (sel == 1) {
      g = int(red(c));
    } else if (sel == 2) {
      b = int(red(c));
    } else if (sel == 3) {
      r = int(red(c));
      g = int(red(c));
      b = int(red(c));
    }

    sendToArd(r, g, b);
  }
  background(c);
}

/////////////////////////////


void connectToArd(String com) {
  printArray(Serial.list());

  ard = new Serial(this, com, 9600);
}

void sendToArd(float r_, float g_, float b_) {
  ard.write('S'); 
  ard.write(int(r_));
  ard.write(int(g_));
  ard.write(int(b_));
}

color musicOneColor(color clr) {
  int count = 0;
  int lowTot = 0;
  int s, h, br;

  for (int i = 0; i < player.left.size()/3.0; i+=5) {
    lowTot+= (abs(player.left.get(i)) * 70);
    count++;
  }

  colorMode(HSB, 360, 100, 100);

  s = int(saturation(clr));
  h = int(hue(clr));

  br = int(map( lowTot * 4, 0, count * 50, 0, 100));

  color c = color(h, s, br);

  colorMode(RGB, 255, 255, 255);

  //println("HSB: " + h + " " + br + " " + "RGB: " + r+ " " + g + " " + b);

  return c;
}
