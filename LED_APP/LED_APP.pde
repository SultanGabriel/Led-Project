Checkbox cbSynced, cbRandom, cbColorSync, cbFade;
Slider sliders[] = new Slider[6];

void setup() {
	size(400, 350);
	setIcon();
	minim = new Minim(this);
	getMixer();
	player = minim.getLineIn();

	connectToArd();

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


	icon.resize(50, 50);

}

color c;
color sliderColor;
void draw() {
	colorMode(RGB, 255, 255, 255);
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

	if(!fade && !colorSync) {
		for(int i = 0; i < 3; i++) {
			sliders[i].update();
		}
		sliders[5].update();
	} else if(colorSync) {
		sliders[5].update();
	} else if(fade) {
		sliders[3].update();
		sliders[4].update();
	}

	colorMode(RGB, 255, 255, 255);
	sliderColor = color(sliders[0].value, sliders[1].value, sliders[2].value);
	if (musicSinced && !colorSync && !randomSync) { //SYNC ONE COLOR
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
	}

	//colorWheel(125);
	//colorSquare();
	

	if (debugMouse) {
		text(mouseX + ", " + mouseY, mouseX + 5, mouseY - 5);
		stroke(255, 0, 0);
		line(mouseX, 0, mouseX, height);
		line(0, mouseY, width, mouseY);
	}
}

/*
       /

/*
        IMPORTANT
    TODO rewrite the "picker"
    TODO add a color circle or something similar

    TODO rewrite the checkbox class

    TODO ADD PROFILES

        NOT AS IMPORTANT
    TODO settings tab
    TODO redesign the sliders
    TODO better background color
    TODO better icon / logo
        TODO Be able to add custom modes

        NOT REALLY IMPORTANT
    TODO make the config a cfg or json // it doen't really matter
    TODO
 */
