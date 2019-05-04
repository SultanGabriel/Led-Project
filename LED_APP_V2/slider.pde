class Slider {	//TODO rewrite or rethink the Slider class! //TODO be able to click on the slider and have it move to the mouse position
	float x;
	float y;
	float sWidth;
	float minValue;
	float maxValue;

	float value;
	float posX;
	float dotWidth = 10;
	float dotHeight = 15;

	boolean lock = false;

	color sliderColor = color(0);
	color dotColor = color(0);

	String id;
	//default
	Slider () {
	}

	Slider (float _x, float _y, float _sWidth, float _minValue, float _maxValue) {
		x=_x;
		y=_y;
		sWidth =_sWidth;

		minValue = _minValue;
		maxValue = _maxValue;

		posX = int(map(value, minValue, maxValue, x, sWidth + x));
	}

	Slider (float _x, float _y, float _sWidth, float _minValue, float _maxValue, float _value) {
		x = _x;
		y = _y;
		sWidth = _sWidth;

		minValue = _minValue;
		maxValue = _maxValue;

		value = _value;

		posX = int(map(value, minValue, maxValue, x, sWidth + x));
	}

	void setValue(float _value){
		value = _value;
		posX = int(map(value, minValue, maxValue, x, sWidth + x));
	}

	void show() {
		fill(sliderColor);
		rect(x, y, sWidth, 4);

		fill(dotColor);
		rect(posX-0.5 * dotWidth, y - 0.5 * dotHeight, dotWidth, dotHeight);
	}

	void update() {
		value = map(posX - x, 0, sWidth, minValue, maxValue );
		float mx = constrain(mouseX, x, sWidth + x);//constrain(mouseX, x, sWidth + dotWidth * 2);
		if (lock) posX = mx;

		show();

		if(debug) println("ID: " + id + "Value: " + value);
	}

	boolean isOver()
	{
		return ( mouseX >= posX - dotWidth * 0.5 ) && ( mouseX <= posX + dotWidth * 0.5 ) &&
		       ( mouseY >= y - dotHeight * 0.5 ) && ( mouseY <= y + dotHeight * 0.5 );
	}
}