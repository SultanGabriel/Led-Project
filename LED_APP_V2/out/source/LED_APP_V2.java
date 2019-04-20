import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import processing.serial.*; 
import ddf.minim.*; 
import javax.sound.sampled.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class LED_APP_V2 extends PApplet {

Checkbox cbSynced, cbRandom, cbColorSync, cbFade;
Slider sliders[] = new Slider[6];
Picker picker;

public void setup() {
	
	setIcon();
	minim = new Minim(this);
	getMixer();
	player = minim.getLineIn();
	connectToArd();
	icon.resize(50, 50);

// -- Initialization Classes -- //
	//red
	sliders[0] = new Slider(50, 150, 300, 0, 255);
	sliders[0].dotColor = color(255, 3, 0);
	sliders[0].id = "Blue";
	//green
	sliders[1] = new Slider(50, 200, 300, 0, 255);
	sliders[1].dotColor = color(0, 253, 0);
	sliders[1].id = "Green";
	//blue
	sliders[2] = new Slider(50, 250, 300, 0, 255);
	sliders[2].id = "Red";
	sliders[2].dotColor = color(0, 0, 3255);
	//fade speed
	sliders[3] = new Slider(50, 150, 300, 0.01f, 2, 0.2f);
	sliders[3].id = "Fade Speed";
	//fade brightness
	sliders[4] = new Slider(50, 100, 300, 0, 100, 25);
	sliders[4].id = "Fade Brightness";
	sliders[4].dotColor = color(255);
	//Brightness
	sliders[5] = new Slider(50, 100, 300, 0, 100, 25);
	sliders[5].id = "Brightness";
	sliders[5].dotColor = color(255);
	//Random
	/*
	   sliders[5] = new Slider(50, 100, 300, 0, 100, 25);
	   sliders[5].id = "Brightness";
	   sliders[5].dotColor = color(255);*/

	cbSynced = new Checkbox(75, 20, "Sync to music");
	cbRandom = new Checkbox(75, 35, "Random", cbSynced);
	cbColorSync = new Checkbox(75, 50, "Hue", cbSynced);

	cbFade = new Checkbox(225, 20, "Fade");

	picker = new Picker(200, 175, 200);

}

int c;
int sliderColor;
public void draw() {
RGB();
	background(bgColor);
	image(icon, 0, 0);

	cbSynced.update();
	cbRandom.update();
	cbColorSync.update();
	cbFade.update();

	randomSync = cbRandom.checked;
	musicSinced = cbSynced.checked;
	colorSync = cbColorSync.checked;
	fade = cbFade.checked;

	/*if(!fade && !colorSync) {
	        for(int i = 0; i < 3; i++) {
	                sliders[i].update();
	        }
	        sliders[5].update();
	   } else if(colorSync) {
	        sliders[5].update();
	   } else if(fade) {
	        sliders[3].update();
	        sliders[4].update();
	   }*/

	RGB();
	sliderColor = color(sliders[0].value, sliders[1].value, sliders[2].value);
	/*if (musicSinced && !colorSync && !randomSync) { //SYNC ONE COLOR
	        c = musicOneColor(sliderColor);
	        sendToArd(c);

	   } else if (musicSinced && colorSync && !randomSync) { //COLOR SYNC
	        float br = sliders[5].value;
	        c = musicColorSynced(br);
	        sendToArd(c);

	   } else if (musicSinced && !colorSync && randomSync) { //RANDOM SYNC
	        c = musicRnd();
	        sendToArd(c);

	   } else if (fade) { //FADE
	        float br = sliders[4].value;
	        float speed = sliders[3].value;
	        c = fade(speed, br);
	        sendToArd(c);

	   } else {
	        c = sliderColor;
	        if (mousePressed) {
	                sendToArd(c);
	        }
	   }*/

	//colorWheel(125);
	//colorSquare();

	//ellipse(200, 175, 250, 250);
	picker.update();
	picker.drawPicker();

	if (debugMouse) {
		text(mouseX + ", " + mouseY, mouseX + 5, mouseY - 5);
		stroke(255, 0, 0);
		line(mouseX, 0, mouseX, height);
		line(0, mouseY, width, mouseY);
	}
}

public void HSB(){
	colorMode(HSB, 360, 100, 100);
}
public void RGB(){
	colorMode(RGB, 255, 255, 255);
}
/*

       /
   /*
        IMPORTANT
    TODO rewrite the "picker"
    TODO add a color circle or something similar

    TODO rewrite the checkbox class

    TODO ADD PROFILES
    TODO make the config a cfg or json // it doen't really matter

        NOT AS IMPORTANT

    TODO settings tab
    TODO redesign the sliders
    TODO better background color
    TODO better icon / logo
    TODO Be able to add custom modes

        NOT REALLY IMPORTANT

    TODO
 */
public class Checkbox {
int x, y;
int size = 10;
int hSize = PApplet.parseInt(size / 2);
boolean mOver = false;
boolean checked = false;
String label;

boolean textRect = false;

Checkbox cb;
boolean gotCB = false;
boolean cbChecked = true;

Checkbox(int x_, int y_, String label_) {
	x = x_;
	y = y_;
	label = label_;
}

Checkbox(int x_, int y_, String label_, Checkbox cb_) {
	gotCB = true;
	cb = cb_;
	x = x_;
	y = y_;
	label = label_;
}

public void show() {
	textSize(size * 1.25f);
	if (cbChecked) {
		fill(255);
		stroke(0);
		strokeWeight(1);
		rect(x - 0.5f * size, y - 0.5f * size, size, size);

		if (textRect) {
			int z = floor(textWidth(label));
			rect(x + hSize + 2, y - hSize - 2, z + 4, size + 4);
		}

		if (checked) {
			noStroke();
			fill(255, 0, 0);
			rect(x - 0.5f * size + size * 0.16f, y - hSize + size * 0.16f, size * 0.7f, size * 0.7f);
		}

		noStroke();
		fill(0);
		text(label, x + size * 0.5f + 5, y + hSize);
	}
}

int ml;

public void update() {
	if (gotCB) {
		cbChecked = cb.checked;

	} else {
		cbChecked = true;
		
	}

	int mx = mouseX;
	int my = mouseY;

	mOver = false;
	if (x - size / 2 < mx && x + size / 2 > mx &&
	    y - size / 2 < my && y + size / 2 > my) {
		mOver = true;
	}

	if (mOver && mousePressed && ml + 100 < millis() ) {
		checked = !checked;
		ml = millis();
	}
	this.show();
}
}
//  <<<--->>> <<<--->>> <<<--->>> <<<--->>>
int segs = 12;
int steps = 16;
float rotAdjust = TWO_PI / segs / 2;
float radius;
float segWidth;
float interval = TWO_PI / segs;

int sizeX; 
int sizeY;

public void shadeWheelSETUP(int sizeX_, int sizeY_) {
  sizeX = sizeX_;
  sizeY = sizeY_;
  smooth();
  ellipseMode(RADIUS);

  radius = min(sizeX, sizeY) * 0.45f;
  segWidth = radius / steps;
}

public void drawShadeWheel() {
  //background(255);

  for (int j = 0; j < steps; j++) {
    int[] cols = {
      color(255-(255/steps)*j, 255-(255/steps)*j, 0), 
      color(255-(255/steps)*j, (255/1.5f)-((255/1.5f)/steps)*j, 0), 
      color(255-(255/steps)*j, (255/2)-((255/2)/steps)*j, 0), 
      color(255-(255/steps)*j, (255/2.5f)-((255/2.5f)/steps)*j, 0), 

      color(255-(255/steps)*j, 0, 0), // red
      color(255-(255/steps)*j, 0, (255/2)-((255/2)/steps)*j), 
      color(255-(255/steps)*j, 0, 255-(255/steps)*j), 
      color((255/2)-((255/2)/steps)*j, 0, 255-(255/steps)*j), 

      color(0, 0, 255-(255/steps)*j), //blue
      color(0, 255-(255/steps)*j, (255/2.5f)-((255/2.5f)/steps)*j), 

      color(0, 255-(255/steps)*j, 0), //green
      color((255/2)-((255/2)/steps)*j, 255-(255/steps)*j, 0)
    };
    noStroke();
    for (int i = 0; i < segs; i++) {
      /*fill(255);
       ellipse(sizeX/2, sizeY/2, radius + segWidth, radius + segWidth);*/
      fill(cols[i]);
      arc(sizeX/2 + 25, height - sizeY/2 - 25, radius, radius, 
        interval*i+rotAdjust, interval*(i+1)+rotAdjust);
      /*fill(0);
       ellipse(sizeX/2, sizeY/2, segWidth, segWidth);*/
    }
    radius -= segWidth;
  }
}
class Picker {
	float x;
	float y;
	float radius;
	float width = 15;
	float increment = PI / 180;
	float currentHue = -75;
	int currentColor;

	float angle = 0;

	Picker(float _x, float _y, float _radius){
		x = _x;
		y = _y;
		radius = _radius;
	}

	public void select(int mX, int mY){
//		int mX = mouseX;
//		int mY = mouseY;

		currentColor = get(mX, mY);
		currentHue = hue(currentColor);

		angle = degrees(atan(mY/mX));

		sendToArd(currentColor);
	}

	public void update(){
		//currentHue = currentHue % 360;
		//currentHue = abs(currentHue);
		//currentColor = color(currentHue, 100, 100);
		sendToArd(currentColor);
	}

	public void drawPicker(){
		noFill();
		strokeWeight(width);
		HSB();

		for(float i = 0; i < TWO_PI; i += increment) {
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




//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
public void colorSquare(){
	HSB();
	for (int i = 0; i < 80; i++) {
		for(int j = 50; j >= 0; j--) {
			fill(i * 4.5f, 100 - j * 2, j * 5);
			rect(i * 5, height - j * 5, 5, 5);
		}
	}
}


public void colorWheel(int r){
	float inc = 0.1f;
	int circles = round(TWO_PI / inc);
	float colorInc = round(300 / circles);
	float h = 0;
	float b = 100;
	int counter = 0;
	for(float j = 1; j <= 5; j++) {
		if(j > 1) {
			r -= 20;
			b -= 20;
		}
		for(float i = 0; i < TWO_PI; i += inc) {
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
boolean musicSinced = false;
boolean randomSync = false;
boolean colorSync = false;
boolean fade = false;
//arduino settings
boolean connectToArduino = false;
int baudrate = 250000;
String COM = "COM5";
//debug !?
boolean debug = false;
boolean debugMouse = false;
//app settings
int bgColor = color(200);
//soundmultiplier
int soundMultiplier = 20;

/*

int r = (c >> 16) & 0xFF;
int g = (c >> 8) & 0xFF;
int b = c & 0xFF;
println("r" + r + " g" + g + " b" + b);

*/




Serial ard;
AudioInput player;
Minim minim;

public void connectToArd() {
	if (debug)
		printArray(Serial.list());

	ard = new Serial(this, COM, baudrate);
}

public void sendToArd(int c) {
	int r = ( c >> 16 ) & 0xFF;
	int g = ( c >> 8 ) & 0xFF;
	int b = c & 0xFF;

	ard.write('S');
	ard.write(r);
	ard.write(g);
	ard.write(b);
}

PImage icon;
public void setIcon(){
	icon = loadImage("./resources/icon.png");
	surface.setIcon(icon);
}

public void getMixer() {
	Mixer.Info[] mixerInfo = AudioSystem.getMixerInfo();
	for (Mixer.Info m : mixerInfo) {
		String name = m.getName();
		if (name.contains("Stereomix")) {
			minim.setInputMixer(AudioSystem.getMixer(m));
			break;
		}
	}
}

public void mousePressed() {
	for (Slider s : sliders)
	{
		if (s.isOver())
			s.lock = true;
	}
	picker.select(mouseX, mouseY);
	//sendToArd(get(mouseX, mouseY));
}

public void mouseReleased() {
	for (Slider s : sliders)
	{
		s.lock = false;
	}
}

public void mouseWheel(MouseEvent event) {
  float e = event.getCount();
//1  println(e);
//  picker.currentHue += e;
//  picker.update();
}
public int musicColorSynced(float br){
	int count = 0;
	float soundIn;
	int lowTot = 0;
	int s, h;

	for (int i = 0; i < player.left.size()/2.0f; i+=5) {
		soundIn = abs(( player.left.get(i) + player.right.get(i))/2);
		lowTot+= ( soundIn * soundMultiplier );
		count++;
	}
	colorMode(HSB, 360, 100, 100);
	h = floor(map(lowTot, 0, count * soundMultiplier, 0, 360));
	s = 100;

	return color(h, s, br);
}

int clr = color(random(255), random(255),  random(255));
public int musicRnd() {
	int count = 0;
	float soundIn;
	int lowTot = 0;
	int s, h, br;

	for (int i = 0; i < player.left.size()/2.0f; i+=5) {
		soundIn = abs(( player.left.get(i) + player.right.get(i))/2);
		lowTot+= ( soundIn * soundMultiplier );
		count++;
	}
	colorMode(HSB, 360, 100, 100);
	if(lowTot > 1000) {
		clr = color(round(random(360)), 100, 100);
	}
	s = PApplet.parseInt(saturation(clr));
	h = PApplet.parseInt(hue(clr));
	br = floor(map(lowTot, 0, count * soundMultiplier, 0, 100));
	return color(h, s, br);
}

int max = 1974;
public int musicOneColor(int clr) {
	int count = 0;
	float soundIn;
	int lowTot = 0;
	int s, h, br;

	for (int i = 0; i < player.left.size()/2.0f; i+=5) {
		soundIn = abs(( player.left.get(i) + player.right.get(i))/2);
		lowTot+= ( soundIn * soundMultiplier );
		count++;
	}

	colorMode(HSB, 360, 100, 100);

	s = PApplet.parseInt(saturation(clr));
	h = PApplet.parseInt(hue(clr));
	br = PApplet.parseInt(map(lowTot, 0, count * soundMultiplier, 0, 100));

	return color(h, s, br);
}

float h;
float inc;
public int fade(float speed, float b) {
	colorMode(HSB, 360, 100, 100);

	inc = speed;

	h = h % 360;
	h += inc;

	int c = color(h, 100, b);
	return c;
}
class Slider {
	float x;
	float y;
	float sWidth;
	float minValue;
	float maxValue;

	float value;
	float posX;
	float dotWidth = 10;
	float dotHeight = 15;

	boolean lock = false;

	int sliderColor = color(0);
	int dotColor = color(0);

	String id;
	//default
	Slider () {
	}

	Slider (float _x, float _y, float _sWidth, float _minValue, float _maxValue) {
		x=_x;
		y=_y;
		sWidth =_sWidth;

		minValue = _minValue;
		maxValue = _maxValue;

		posX = PApplet.parseInt(map(value, minValue, maxValue, x, sWidth + x));
	}

	Slider (float _x, float _y, float _sWidth, float _minValue, float _maxValue, float _value) {
		x = _x;
		y = _y;
		sWidth = _sWidth;

		minValue = _minValue;
		maxValue = _maxValue;

		value = _value;

		posX = PApplet.parseInt(map(value, minValue, maxValue, x, sWidth + x));
	}

	public void setValue(float _value){
		value = _value;
		posX = PApplet.parseInt(map(value, minValue, maxValue, x, sWidth + x));
	}

	public void show() {
		fill(sliderColor);
		rect(x, y, sWidth, 4);

		fill(dotColor);
		rect(posX-0.5f * dotWidth, y - 0.5f * dotHeight, dotWidth, dotHeight);
	}

	public void update() {
		value = map(posX - x, 0, sWidth, minValue, maxValue );
		float mx = constrain(mouseX, x, sWidth + x);//constrain(mouseX, x, sWidth + dotWidth * 2);
		if (lock) posX = mx;

		show();

		if(debug) println("ID: " + id + "Value: " + value);
	}

	public boolean isOver()
	{
		return ( mouseX >= posX - dotWidth * 0.5f ) && ( mouseX <= posX + dotWidth * 0.5f ) &&
		       ( mouseY >= y - dotHeight * 0.5f ) && ( mouseY <= y + dotHeight * 0.5f );
	}
}
  public void settings() { 	size(400, 350); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "LED_APP_V2" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
