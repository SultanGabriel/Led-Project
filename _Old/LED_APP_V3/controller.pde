import processing.serial.*;
import ddf.minim.*;
import javax.sound.sampled.*;

Serial ard;
AudioInput player;
Minim minim;

void connectToArd() {
	if (debug)
		printArray(Serial.list());
	if(outputEnable)
		ard = new Serial(this, COM, baudrate);
}

void sendToArd(int c) {
	if(outputEnable) {
		println(c);

		int r = ( c >> 16 ) & 0xFF;
		int g = ( c >> 8 ) & 0xFF;
		int b = c & 0xFF;

		ard.write(r);
		ard.write(g);
		ard.write(b);
		//ard.write(c);
	}
}

PImage icon;
void setIcon(){
	icon = loadImage(iconPATH);
	surface.setIcon(icon);
}

void getMixer() {
	Mixer.Info[] mixerInfo = AudioSystem.getMixerInfo();
	//println(mixerInfo);
	for (Mixer.Info m : mixerInfo) {
		String name = m.getName();
		if (name.contains("Stereomix")) {
			minim.setInputMixer(AudioSystem.getMixer(m));
			break;
		}
	}
}

void mousePressed() {
	// for (Slider s : sliders)
	// {
	// 	if (s.isOver())
	// 		s.lock = true;
	// }

	if(fadeSpeedSlider.isOver()) {
		fadeSpeedSlider.lock = true;
	}

	if(brightnessSlider.isOver()) {
		brightnessSlider.lock = true;
	}
	if(vBrightnessSlider.isOver()) {
		vBrightnessSlider.lock = true;
	}

	float d = dist(picker.x, picker.y, mouseX, mouseY);

	if(91 <  d && d < 119) {         // 90 - 110
		picker.select(mouseX, mouseY);
	}

	if(settings.mouseOver) {
		settings.open = !settings.open;
	}
	//println("MX " + mouseX + " MY " + mouseY + " CX " + picker.cx + " CY " + picker.cy);
}

void mouseReleased() {
	// for (Slider s : sliders)
	// {
	// 	s.lock = false;
	// }
	fadeSpeedSlider.lock = false;
	brightnessSlider.lock = false;
	vBrightnessSlider.lock = false;
}

void HSB(){
	colorMode(HSB, 360, 100, 100);
}
void RGB(){
	colorMode(RGB, 255, 255, 255);
}
