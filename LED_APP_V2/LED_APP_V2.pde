Checkbox cbSynced, cbRandom, cbColorSync, cbFade, cbFadeToRandom;
Slider fadeSpeedSlider, brightnessSlider;       //fadeBrightnessSlider
Slider vBrightnessSlider; // VERTICAL SLIDER
Picker picker;
Settings settings;
PImage settingsIcon;
// IDEA try some color as bg or the user could set the color in the settings, but just a BIT color like a black with a tint of blue or red

//	FIXME you can't change the brightness 
//	FIXME the app stops responding, give the option to select the com port 

// TODO CREATE A NEW CLASS FOR VERTICAL SLIDERS

//	WIP REDESIGN THE APP
//	WIP settings tab

//  TODO make the config a cfg or json for settings

//  TODO better background
//  TODO better icon / logo

//  TODO add profiles tab
//  TODO ADD PROFILES

// 	IDEA do I need the hue sync mode ?? it's kind of ugly

//  IDEA Be able to add custom modes

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

	//fade brightness
	// sliders[1] = new Slider(50, 100, 300, 0, 100, 25);
	// sliders[1].id = "Fade Brightness";
	// sliders[1].dotColor = color(255);

	//fade speed
	fadeSpeedSlider = new Slider(50, 150, 300, 0.01, 2, 0.5);
	fadeSpeedSlider.id = "Fade Speed";

	//Brightness
	brightnessSlider = new Slider(50, 100, 300, 0, 100, 50);
	brightnessSlider.id = "Brightness";
	brightnessSlider.dotColor = color(255);

	vBrightnessSlider = new Slider(330, 80, 280, 0, 100, 80);
	vBrightnessSlider.id = "Vertical Brightness Slider";
	vBrightnessSlider.vertical = true;

	//>>>>>>>>>>>>>>>Checkboxes<<<<<<<<<<<<<<<<<<

	cbSynced = new Checkbox(75, 20, "Sync to music");
	cbRandom = new Checkbox(75, 35, "Random", cbSynced);
	//cbColorSync = new Checkbox(75, 50, "Hue", cbSynced);

	cbFade = new Checkbox(225, 20, "Fade");
	cbFadeToRandom = new Checkbox(225, 40, "Fade to Random");

	picker = new Picker(180, 200, 200);

	picker.currentColor = defaultColor;
}

color c;
color selectedColor;

void draw() {
	RGB();
	background(bgColor);

	image(icon, 0, 0);

	cbSynced.update();
	cbRandom.update();
	//cbColorSync.update();
	cbFade.update();
	cbFadeToRandom.update();

	if(!settings.open) {
		cbSynced.show();
		cbRandom.show();
		//cbColorSync.show();
		cbFade.show();
		cbFadeToRandom.show();
	}


	//TODO the random and hue checkboxes should not be able to be checked at the same time
	//

	randomSync = cbRandom.checked;
	musicSinced = cbSynced.checked;
	//colorSync = cbColorSync.checked;
	fade = cbFade.checked;
	fadetorandom = cbFadeToRandom.checked;
	settings.update();
	settings.drawButton();

	if(settings.open) {
		settings.show();
	} else if(!fade && !colorSync && !fadetorandom) {
		picker.drawPicker();
		vBrightnessSlider.show();
		//sliders[5].update();
		//} else if(colorSync) {
		//	brightnessSlider.update();
	} else if(fade || fadetorandom) {
		fadeSpeedSlider.update();
		brightnessSlider.update();
	}

	//sliderColor = color(sliders[0].value, sliders[1].value, sliders[2].value);
	selectedColor = picker.currentColor;
	//TODO REWRITE THE MODE SELECTOR ( USE SWITCH )
	if (musicSinced && !colorSync && !randomSync) {   //SYNC ONE COLOR
		c = musicOneColor(selectedColor);
		sendToArd(c);

	} else if (musicSinced && colorSync && !randomSync) {    //COLOR SYNC
		float br = brightnessSlider.value;
		c = musicColorSynced(br);
		sendToArd(c);

	} else if (musicSinced && !colorSync && randomSync) {    //RANDOM SYNC
		c = musicRnd();
		sendToArd(c);

	} else if (fade) {    //FADE
		float br = brightnessSlider.value;
		float speed = fadeSpeedSlider.value;
		c = fade(speed, br);
		sendToArd(c);

	} else if (fadetorandom) {
		float br = brightnessSlider.value;
		float speed = fadeSpeedSlider.value;
		c = fadeToRandom(c, speed, br);
		sendToArd(c);
	} else if(c != selectedColor) {
		sendToArd(selectedColor);
		c = selectedColor;
	}

	//colorWheel(125);
	//colorSquare();

	if (debugMouse) {
		text(mouseX + ", " + mouseY, mouseX + 5, mouseY - 5);
		stroke(255, 0, 0);
		line(mouseX, 0, mouseX, height);
		line(0, mouseY, width, mouseY);
	}

	// 	slider for brightness position --
	// <<	line(330, 80, 330, 320);	>>
}

void HSB(){
	colorMode(HSB, 360, 100, 100);
}
void RGB(){
	colorMode(RGB, 255, 255, 255);
}
