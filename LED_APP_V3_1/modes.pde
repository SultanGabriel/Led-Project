color musicColorSynced(float br){
	int count = 0;
	float soundIn;
	int lowTot = 0;
	int s, h;

	for (int i = 0; i < player.left.size()/2.0; i+=5) {
		soundIn = abs(( player.left.get(i) + player.right.get(i))/2);
		lowTot+= ( soundIn * soundMultiplier );
		count++;
	}
  HSB();
	h = floor(map(lowTot, 0, count * soundMultiplier, 0, 360));
	s = 100;

	return color(h, s, br);
}

color clr = color(random(255), random(255),  random(255));
color musicRnd() {
	int count = 0;
	float soundIn;
	int lowTot = 0;
	int s, h, br;

	for (int i = 0; i < player.left.size()/2.0; i+=5) {
		soundIn = abs(( player.left.get(i) + player.right.get(i))/2);
		lowTot+= ( soundIn * soundMultiplier );
		count++;
	}
	HSB();
	if(lowTot > rColorSwitchThr) {
		clr = color(round(random(360)), 100, 100);
	}

	s = int(saturation(clr));
	h = int(hue(clr));
	br = floor(map(lowTot, 0, count * soundMultiplier, 0, 100));
	return color(h, s, br);
}

int max = 1974;
color musicOneColor(color clr) {
	int count = 0;
	float soundIn;
	int lowTot = 0;
	int s, h, br;

	for (int i = 0; i < player.left.size()/2.0; i+=5) {
		soundIn = abs((player.left.get(i) + player.right.get(i))/2);
		lowTot+= (soundIn * soundMultiplier );
		count++;
	}

	HSB();

	s = int(saturation(clr));
	h = int(hue(clr));
	br = int(map(lowTot, 0, count * soundMultiplier, 0, 100));

	return color(h, s, br);
}

float h;
float inc;
color fade(float speed, float b) {
  HSB();

	inc = speed;

	h = h % 360;
	h += inc;

	color c = color(h, 100, b);
	return c;
}
color randomColor;

color fadeToRandom(color c, float increment, float brightness){ //WIP write the fadeToRandom mode
	HSB(); //FIXME This isn't working right =////
	if (randomColor == 0 || floor(hue(c)) == floor(hue(randomColor))) {
		int rnd = round(random(360));
		println(rnd);
		randomColor = color(rnd, 100, 100);
	}
	println(hue(c), hue(randomColor), increment);


	//if(h == 0) h = 1;
	float h = hue(c);
	float hRnd = hue(randomColor);
	if(h < hRnd) {
		h += increment * 2;
	} else if (h > hRnd) {
		h -= increment * 2;
	}
//	h = floor(h);

	return color(h, 100, brightness);
}
