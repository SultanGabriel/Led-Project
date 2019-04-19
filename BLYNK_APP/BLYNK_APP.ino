/*************************************************************
  Download latest Blynk library here:
    https://github.com/blynkkk/blynk-library/releases/latest

  Blynk is a platform with iOS and Android apps to control
  Arduino, Raspberry Pi and the likes over the Internet.
  You can easily build graphic interfaces for all your
  projects by simply dragging and dropping widgets.

    Downloads, docs, tutorials: http://www.blynk.cc
    Sketch generator:           http://examples.blynk.cc
    Blynk community:            http://community.blynk.cc
    Follow us:                  http://www.fb.com/blynkapp
                                http://twitter.com/blynk_app

  Blynk library is licensed under MIT license
  This example code is in public domain.

 *************************************************************
  =>
  =>          USB HOWTO: http://tiny.cc/BlynkUSB
  =>

  Blynk using a LED widget on your phone!

  App project setup:
    LED widget on V1
 *************************************************************/

/* Comment this out to disable prints and save space */
#define BLYNK_PRINT SwSerial


#include <SoftwareSerial.h>
SoftwareSerial SwSerial(10, 12); // RX, TX

#include <BlynkSimpleStream.h>

// You should get Auth Token in the Blynk App.
// Go to the Project Settings (nut icon).
char auth[] = "df45bf3e324b41929d3eb505832f2d82";
bool fade = false;
WidgetTerminal terminal(V0);
WidgetLED led(V2);
float fadeSpeed = 2;

#define RED_PIN 3
#define GREEN_PIN 6
#define BLUE_PIN 11

int r = 255;
int g = 0;
int b = 0;
int t = 0;
bool reset = true;
BLYNK_WRITE(V1)
{
  int value = param.asInt(); // assigning incoming value from pin V1 to a variable
  if (value == 1) {
    if (reset) {
      r = 255;
      g = 0;
      b = 0;
      t = 0;
      reset = false;

    }
    fade = true;
  } else if (value == 0) {
    reset = true;
    led.setColor("#000000");
    fade = false;
  }
}
BLYNK_WRITE(V3) {
  fadeSpeed = param.asInt(); // assigning incoming value from pin V1 to a variable
}

void setup() {
  SwSerial.begin(9600);
  Serial.begin(9600);
  Blynk.begin(Serial, auth);

  pinMode(RED_PIN, OUTPUT);
  pinMode(GREEN_PIN, OUTPUT);
  pinMode(BLUE_PIN, OUTPUT);

  Blynk.virtualWrite(V1, 0);
  Blynk.virtualWrite(V2, fadeSpeed);

  led.on();
  led.setColor("#000000");
}
int oldT = 10;
void loop() {
  if (fade) {
    if (t != oldT) {
      terminal.println(t);
      terminal.flush();
      oldT = t;
    }
    //t = t % 6;
    if (t == 0) {
      r = 255;
      g += fadeSpeed;
      b = 0;

      if (g >= 255 - fadeSpeed){
              terminal.println("RESETED");
      terminal.flush();
        t = 1;
        }
    } else if (t == 1) {
      r -= fadeSpeed;
      g = 255;
      b = 0;

      if (r <= 0)
        t = 2;
    } else if (t == 2) {
      r = 0;
      g = 255;
      b += fadeSpeed;

      if (b >= 255 - fadeSpeed)
        t = 3;
    } else if (t == 3) {
      r = 0;
      g -= fadeSpeed;
      b = 255;

      if (g <= 0)
        t = 4;
    } else if (t == 4) {
      r += fadeSpeed;
      g = 0;
      b = 255;

      if (r >= 255 - fadeSpeed)
        t = 5;
    } else if (t == 5) {
      r = 255;
      g = 0;
      b -= fadeSpeed;

      if (b <= 0)
        t = 0;
    }

    byte R = r;
    byte G = g;
    byte B = b;
    long RGB = ((long)R << 16L) | ((long)G << 8L) | (long)B;

    led.setColor(RGB);

    analogWrite(RED_PIN, r);
    analogWrite(GREEN_PIN, g);
    analogWrite(BLUE_PIN, b);
  }

  Blynk.run();

}
