Checkbox cbSynced, cbRandom, cbColorSync, cbFade, cbFadeToRandom;
Slider sliders[] = new Slider[6];
Picker picker;

PImage settingsIcon;
Settings settings;
//	TODO add settings WIP

//  TODO Add a way to turn the brightness down

//	TODO REDESIGN THE APP
// 	TODO add profiles tab
//  TODO better background 
//  TODO better icon / logo
//  TODO ADD PROFILES
//  TODO make the config a cfg or json 
//  TODO Be able to add custom modes

void setup() {

	size(400, 350);
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
	sliders[3] = new Slider(50, 150, 300, 0.01, 2, 0.2);
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

	picker = new Picker(200, 200, 200);
	picker.currentColor = defaultColor;
}

color c;
color selectedColor;

void draw() {
	RGB();
	background(bgColor);

	image(icon, 0, 0);

	if(!settings.open) {

		cbSynced.update();
		cbRandom.update();
		cbColorSync.update();
		cbFade.update();
		cbFadeToRandom.update();
	}

	//TODO the random and hue checkboxes should not be able to be checked
	//				 at the same time

	randomSync = cbRandom.checked;
	musicSinced = cbSynced.checked;
	colorSync = cbColorSync.checked;
	fade = cbFade.checked;

	settings.update();
	settings.drawButton();

	if(settings.open) {
		settings.show();
	} else if(!fade && !colorSync) {
		picker.drawPicker();
		//sliders[5].update();
	} else if(colorSync) {
		sliders[5].update();
	} else if(fade) {
		sliders[3].update();
		sliders[4].update();
	}

	//sliderColor = color(sliders[0].value, sliders[1].value, sliders[2].value);
	selectedColor = picker.currentColor; //TODO REWRITE THE MDOE SELECTOR ( USE SWITCH )
	if(settings.open) {

	} else if (musicSinced && !colorSync && !randomSync) { //SYNC ONE COLOR
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

	} else {
		if(c != selectedColor) {
			sendToArd(selectedColor);
		}
		c = selectedColor;
	}

	//colorWheel(125);
	//colorSquare();

	//ellipse(200, 175, 250, 250);


	if (debugMouse) {
		text(mouseX + ", " + mouseY, mouseX + 5, mouseY - 5);
		stroke(255, 0, 0);
		line(mouseX, 0, mouseX, height);
		line(0, mouseY, width, mouseY);
	}
}

void HSB(){
	colorMode(HSB, 360, 100, 100);
}
void RGB(){
	colorMode(RGB, 255, 255, 255);
}
