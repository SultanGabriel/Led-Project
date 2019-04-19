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
void colorSquare(){
	colorMode(HSB, 300, 100, 100);
	for (int i = 0; i < 80; i++) {
		for(int j = 50; j >= 0; j--) {
			fill(i * 4.5, 100 - j * 2, j * 5);
			rect(i * 5, height - j * 5, 5, 5);
		}
	}
}