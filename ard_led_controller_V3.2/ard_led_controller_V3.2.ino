#define RED_PIN 3
#define GREEN_PIN 6
#define BLUE_PIN 11
#define LIGHTS_PIN 5

int r, g, b;
float lights = false;

void setup() {
  Serial.begin(500000);
  pinMode(RED_PIN, OUTPUT);
  pinMode(GREEN_PIN, OUTPUT);
  pinMode(BLUE_PIN, OUTPUT);
  pinMode(LIGHTS_PIN, OUTPUT);
  pinMode(12, OUTPUT);

}

void loop() {
  analogWrite(RED_PIN, r);
  analogWrite(GREEN_PIN, g);
  analogWrite(BLUE_PIN, b);

  if(lights){
    digitalWrite(LIGHTS_PIN, HIGH);
  }else{
    digitalWrite(LIGHTS_PIN, LOW);
  }

  if (Serial.available()) {
    byte temp = Serial.read();
    if (temp == 'S') {
      while (!Serial.available()) {}
      r = Serial.read();
      while (!Serial.available()) {}
      g = Serial.read();
      while (!Serial.available()) {}
      b = Serial.read();
    }  
    if (temp == 'L') {
      lights = true;
    }  
    if (temp == 'F') {
      lights = false;
    }
  }
}
