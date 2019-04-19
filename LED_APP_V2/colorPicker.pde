class Picker {
	float x;
	float y;
	float radius;
	float width = 15;
	float increment = PI / 180;
	float currentHue = -75;
	color currentColor;

	float angle = 0;

	Picker(float _x, float _y, float _radius){
		x = _x;
		y = _y;
		radius = _radius;
	}

	void select(int mX, int mY){
//		int mX = mouseX;
//		int mY = mouseY;

		currentColor = get(mX, mY);
		currentHue = hue(currentColor);

		angle = degrees(atan(mY/mX));
		println(angle);

		sendToArd(currentColor);
	}

	void update(){
		println(currentHue);
		currentHue = currentHue % 360;
		currentHue = abs(currentHue);
		currentColor = color(currentHue, 100, 100);
		sendToArd(currentColor);

	}

	void drawPicker(){
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
void colorSquare(){
	HSB();
	for (int i = 0; i < 80; i++) {
		for(int j = 50; j >= 0; j--) {
			fill(i * 4.5, 100 - j * 2, j * 5);
			rect(i * 5, height - j * 5, 5, 5);
		}
	}
}


void colorWheel(int r){
	float inc = 0.1;
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