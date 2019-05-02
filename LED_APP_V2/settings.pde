class Settings {
	int buttonX;
	int buttonY;

	Settings(){
	}

	setup(){

	}

	setButtonPos(int x, int y){
		buttonX = x;
		buttonY = y;
	}

	drawButton(){
		image(settingsIcon, width - 30, 5);
	}

	show(){

	}
}