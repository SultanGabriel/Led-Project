import processing.serial.*;
import ddf.minim.*;
import javax.sound.sampled.*;

Serial ard;
AudioInput player;
Minim minim;

void connectToArd() {
	if (debug)
		printArray(Serial.list());
	
	ard = new Serial(this, COM, baudrate);
}

void sendToArdSecColor(boolean secLights) {
	if (outputEnable) {
		if (secLights) {
			ard.write('L');
		}else {
			ard.write('F');
		}
	}
}

void sendToArd(color c) {
	if (outputEnable) {
		int r = (c >> 16) & 0xFF;
		int g = (c >> 8) & 0xFF;
		int b = c & 0xFF;
		
		ard.write('S');
		ard.write(r);
		ard.write(g);
		ard.write(b);
	}
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

PImage icon;
void setIcon() {
  icon = loadImage(iconPATH);
  surface.setIcon(icon);
}

void mousePressed() {
	// for (Slider s : sliders)
	// {
	// 	if (s.isOver())
	// 		s.lock = true;
	// }
	
	if (fadeSpeedSlider.isOver()) {
		fadeSpeedSlider.lock = true;
	}
	
	if (brightnessSlider.isOver()) {
		brightnessSlider.lock = true;
	}
	
	if (thresholdSlider.isOver()) {
		thresholdSlider.lock = true;
	}
	
	if (vBrightnessSlider.isOver()) {
		vBrightnessSlider.lock = true;
	}
	
	float d = dist(picker.x, picker.y, mouseX, mouseY);
	
	if (91 <  d && d < 119) {         // 90 - 110
		picker.select(mouseX, mouseY);
	}
	
	if (settings.mouseOver) {
		settings.open = !settings.open;
	}
	
	
	if (debugMouse) {
		println("MX " + mouseX + " MY " + mouseY);
	}
}

void mouseReleased() {
	// for (Slider s : sliders)
	// {
	// 	s.lock = false;
	// }
	
	thresholdSlider.unlock();
	fadeSpeedSlider.unlock();
	brightnessSlider.unlock();
	vBrightnessSlider.unlock();
}
