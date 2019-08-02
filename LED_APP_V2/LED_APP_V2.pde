Checkbox cbSynced, cbRandom, cbColorSync, cbFade, cbFadeToRandom;
Slider sliders[] = new Slider[6];
Picker picker;

PImage settingsIcon;
Settings settings;
// IDEA turn it into OR made a dark mode
// IDEA try some color as bg or the user could set the color in the settings, but just a BIT color like a black with a tint of blue or red

//	FIXME you can't change the brightness 
//	FIXME the app stops responding, give the option to select the com port 

// TODO CREATE A NEW CLASS FOR VERTICAL SLIDERS

//	WIP REDESIGN THE APP
//	WIP settings tab
//  TODO make the config a cfg or json
//  TODO add more settings!!
//  TODO better background
//  TODO better icon / logo

//  TODO add profiles tab
//  TODO ADD PROFILES

//  TODO Be able to add custom modes

void setup() {
	size(700, 350);
  surface.setResizable(true);
  surface.setTitle("LED Controller");

	setIcon();
	minim = new Minim(this);
	getMixer();
	player = minim.getLineIn();
	connectToArd();

	icon.resize(50, 50);

	settingsIcon = loadImage(settingsIconPATH);
	settingsIcon.resize(25, 25);

	settings = new Settings(width - 30, 5);
	settings.setup();
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
	sliders[3] = new Slider(50, 150, 300, 0.01, 2, 0.5);
	sliders[3].id = "Fade Speed";
	//fade brightness
	sliders[4] = new Slider(50, 100, 300, 0, 100, 25);
	sliders[4].id = "Fade Brightness";
	sliders[4].dotColor = color(255);
	//Brightness
	sliders[5] = new Slider(50, 100, 300, 0, 100, 50);
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
	cbFadeToRandom = new Checkbox(225, 40, "Fade to Random");

	picker = new Picker(550, 210, 200);
	picker.currentColor = defaultColor;
}

color c;
color selectedColor;

void draw() {
	RGB();
	background(bgColor);

	image(icon, 0, 0);
  	drawRightMenuBar();
	cbSynced.update();
	cbRandom.update();
	cbColorSync.update();
	cbFade.update();
	cbFadeToRandom.update();

	if(!settings.open) {
		cbSynced.show();
		cbRandom.show();
		cbColorSync.show();
		cbFade.show();
		cbFadeToRandom.show();
	}


	//TODO the random and hue checkboxes should not be able to be checked
	//				 at the same time

	randomSync = cbRandom.checked;
	musicSinced = cbSynced.checked;
	colorSync = cbColorSync.checked;
	fade = cbFade.checked;
	fadetorandom = cbFadeToRandom.checked;
	settings.update();
	settings.drawButton();

	if(settings.open) {
		settings.show();
	} else if(!fade && !colorSync && !fadetorandom) {
		picker.drawPicker();

		//sliders[5].update();
	} else if(colorSync) {
		sliders[5].update();
	} else if(fade || fadetorandom) {
		sliders[3].update();
		sliders[4].update();
	}

	//sliderColor = color(sliders[0].value, sliders[1].value, sliders[2].value);
	selectedColor = picker.currentColor; //TODO REWRITE THE MDOE SELECTOR ( USE SWITCH )
	if (musicSinced && !colorSync && !randomSync) {   //SYNC ONE COLOR
		c = musicOneColor(selectedColor);
		sendToArd(c);

	} else if (musicSinced && colorSync && !randomSync) {    //COLOR SYNC
		float br = sliders[5].value;
		c = musicColorSynced(br);
		sendToArd(c);

	} else if (musicSinced && !colorSync && randomSync) {    //RANDOM SYNC
		c = musicRnd();
		sendToArd(c);

	} else if (fade) {    //FADE
		float br = sliders[4].value;
		float speed = sliders[3].value;
		c = fade(speed, br);
		sendToArd(c);

	} else if (fadetorandom) {
		float br = sliders[4].value;
		float speed = sliders[3].value;
		c = fadeToRandom(c, speed, br);
		sendToArd(c);
	} else if(c != selectedColor) {
		sendToArd(selectedColor);
		c = selectedColor;
	}

	if (debugMouse) {
		text(mouseX + ", " + mouseY, mouseX + 5, mouseY - 5);
		stroke(255, 0, 0);
		line(mouseX, 0, mouseX, height);
		line(0, mouseY, width, mouseY);
	}
}

void drawRightMenuBar(){
  noStroke();
  fill(sidebarColor);
  rect(400, 0, 300, height);
  fill(topbarColor);
  rect(400, 0, 300, 30);
}

void HSB(){
	colorMode(HSB, 360, 100, 100);
}
void RGB(){
	colorMode(RGB, 255, 255, 255);
}
