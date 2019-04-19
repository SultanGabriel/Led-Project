#define RED_PIN 3
#define GREEN_PIN 6
#define BLUE_PIN 11

int r, g, b;

void setup() {
  Serial.begin(250000);
  pinMode(RED_PIN, OUTPUT);
  pinMode(GREEN_PIN, OUTPUT);
  pinMode(BLUE_PIN, OUTPUT);
}

void loop() {
  analogWrite(RED_PIN, r);
  analogWrite(GREEN_PIN, g);
  analogWrite(BLUE_PIN, b);

  if (Serial.available()) {
    if (Serial.read() == 'S') {
      while (!Serial.available()) {}
      r = Serial.read();
      while (!Serial.available()) {}
      g = Serial.read();
      while (!Serial.available()) {}
      b = Serial.read();
    }
  }
}
