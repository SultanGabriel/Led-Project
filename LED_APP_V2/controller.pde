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

void sendToArd(color c) {
  fill(c);
  ellipse(200, 250, 50, 50);
  
  if(outputEnable){
  	int r = ( c >> 16 ) & 0xFF;
  	int g = ( c >> 8 ) & 0xFF;
  	int b = c & 0xFF;

  	ard.write('S');
  	ard.write(r);
  	ard.write(g);
	  ard.write(b);
  }
}

PImage icon;
void setIcon(){
	icon = loadImage(iconPATH);
	surface.setIcon(icon);
}

void getMixer() {
	Mixer.Info[] mixerInfo = AudioSystem.getMixerInfo();
  println(mixerInfo);
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

	if(91 <  d && d < 119) {         // 90 - 110
		picker.select(mouseX, mouseY);
	}

	if(settings.mouseOver) {
		settings.open = !settings.open;
	}
	//println("MX " + mouseX + " MY " + mouseY + " CX " + picker.cx + " CY " + picker.cy);
}

void mouseReleased() {
	for (Slider s : sliders)
	{
		s.lock = false;
	}
}
void mouseMooved(){


}
void mouseWheel(MouseEvent event) {
	float e = event.getCount();
//  println(e);
//  picker.currentHue += e;
//  picker.update();
}