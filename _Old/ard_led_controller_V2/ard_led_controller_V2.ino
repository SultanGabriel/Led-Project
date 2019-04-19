#include <LiquidCrystal.h>
#define RED_PIN 3
#define GREEN_PIN 5
#define BLUE_PIN 6
int select = 13;
int music = 2;

LiquidCrystal lcd(7, 8, 9, 10, 11, 12);
int Or, Og, Ob;
int r, g, b;

int sel = 0; //selection 0 = r, 1 = g, 2 = b

void setup() {
  Serial.begin(9600);
  lcd.begin(16, 2);

  pinMode(music, INPUT);
  pinMode(select, INPUT);
  pinMode(RED_PIN, OUTPUT);
  pinMode(GREEN_PIN, OUTPUT);
  pinMode(BLUE_PIN, OUTPUT);

  lcd.setCursor(1, 0);
  lcd.print("R  0");
  lcd.setCursor(6, 0);
  lcd.print("G  0");
  lcd.setCursor(11, 0);
  lcd.print("B  0");
}

unsigned long previousMillis = 0;
unsigned long pMils = 0;

boolean m = false;

void loop() {
  unsigned long currentMillis = millis();

  analogWrite(RED_PIN, r);
  analogWrite(GREEN_PIN, g);
  analogWrite(BLUE_PIN, b);

  if (Serial.available()) {
    if (Serial.read() == 'S') {
      r = Or;
      g = Og;
      b = Ob;

      while (!Serial.available()) {}
      r = Serial.read();
      while (!Serial.available()) {}
      g = Serial.read();
      while (!Serial.available()) {}
      b = Serial.read();
      /*
        Serial.print(r);
        Serial.print(" ");
        Serial.print(g);
        Serial.print(" ");
        Serial.println(b);*/
    }
  }

  if (digitalRead(music) == HIGH && currentMillis - previousMillis >= 250) {
    m = !m;
    previousMillis = currentMillis;
    Serial.write("M");

  }
  if (digitalRead(select) == HIGH && currentMillis - previousMillis >= 250) {
    previousMillis = currentMillis;

    sel++;
    sel = sel % 4;

    Serial.write("C");

    lcd.setCursor(1, 0);
    lcd.print("R");
    lcd.setCursor(6, 0);
    lcd.print("G");
    lcd.setCursor(11, 0);
    lcd.print("B");
  }//sel = selection 0 = r, 1 = g, 2 = b

  if (sel != 3) {
    if (!m) {
      int val = analogRead(0);
      if (val < 50) val = 0;
      if (val > 1000) val = 1023;

      if (sel == 0) {//RED

        r = map(val, 0, 1023, 0, 255);
        /*
          if (currentMillis - pMils >= 500 && currentMillis - pMils < 1000) {
          lcd.setCursor(1, 0);
          lcd.print("X");
          } else if (currentMillis - pMils >= 1000) {
          lcd.setCursor(1, 0);
          lcd.print("R");
          pMils = currentMillis;
          }*/

      } else if (sel == 1) { //GREEN
        g = map(val, 0, 1023, 0, 255);

        /*
              if (currentMillis - pMils >= 500 && currentMillis - pMils < 1000) {
                lcd.setCursor(6, 0);
                lcd.print("X");
              } else if (currentMillis - pMils >= 1000) {
                lcd.setCursor(6, 0);
                lcd.print("G");
                pMils = currentMillis;
              }*/


      } else if (sel == 2) { //BLUE
        b = map(val, 0, 1023, 0, 255);
        /*
          if (currentMillis - pMils >= 500 && currentMillis - pMils < 1000) {
          lcd.setCursor(11, 0);
          lcd.print("X");
          } else if (currentMillis - pMils >= 1000) {
          lcd.setCursor(11, 0);
          lcd.print("B");
          pMils = currentMillis;
          }*/

      }
    }/*
    if (m) {
      if (sel == 3) sel = 0;

      if ( sel == 0) {
        g = 0;
        b = 0;
      } else if ( sel == 1) {
        g = r;
        b = 0;
        r = 0;
      } else if ( sel == 2) {
        b = r;
        g = 0;
        r = 0;
      }
    }*/
  }

  show();
}
/*  lcd.setCursor(1, 0);
  lcd.print("R  0");
  lcd.setCursor(6, 0);
  lcd.print("G  0");
  lcd.setCursor(11, 0);
  lcd.print("B  0");*/
void show() {
  if (r != Or) {
    lcd.setCursor(2, 0);
    lcd.write("    ");
    int i = 2;
    if ( r < 10) i = 4;
    if ( r < 100 && r > 10) i = 3;

    lcd.setCursor(i, 0);
    lcd.print(String(r, DEC));
    Or = r;
  }
  if (g != Og) {
    lcd.setCursor(7, 0);
    lcd.write("    ");
    int i = 7;
    if ( g < 10) i = 9;
    if ( g < 100 && g > 10) i = 8;

    lcd.setCursor(i, 0);
    lcd.print(String(g, DEC));
    Og = g;
  }
  if (b != Ob) {
    lcd.setCursor(12, 0);
    lcd.write("    ");
    int i = 12;
    if ( b < 10) i = 14;
    if ( b < 100 && b > 10) i = 13;

    lcd.setCursor(i, 0);
    lcd.print(String(b, DEC));
    Ob = b;
  }

  if (m) {
    lcd.setCursor(1, 1);
    lcd.print("YES");
  } else if (!m) {
    lcd.setCursor(1, 1);
    lcd.print("NO ");
  }
}
