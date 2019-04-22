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

void sendToArd(color c) {
	int r = ( c >> 16 ) & 0xFF;
	int g = ( c >> 8 ) & 0xFF;
	int b = c & 0xFF;

	ard.write('S');
	ard.write(r);
	ard.write(g);
	ard.write(b);
}

PImage icon;
void setIcon(){
	icon = loadImage("./resources/icon.png");
	surface.setIcon(icon);
}

void getMixer() {
	Mixer.Info[] mixerInfo = AudioSystem.getMixerInfo();
	for (Mixer.Info m : mixerInfo) {
		String name = m.getName();
		if (name.contains("Stereomix")) {
			minim.setInputMixer(AudioSystem.getMixer(m));
			break;
		}
	}
}

void mousePressed() {
	for (Slider s : sliders)
	{
		if (s.isOver())
			s.lock = true;
	}
	float d = dist(picker.x, picker.y, mouseX, mouseY);

	if(91 <  d && d < 109) // 90 - 110
		picker.select(mouseX, mouseY);
	//sendToArd(get(mouseX, mouseY));
}

void mouseReleased() {
	for (Slider s : sliders)
	{
		s.lock = false;
	}
}

void mouseWheel(MouseEvent event) {
	float e = event.getCount();
//1  println(e);
//  picker.currentHue += e;
//  picker.update();
}