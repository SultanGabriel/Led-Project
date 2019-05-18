class Settings { //TODO ADD MORE OPTIONS
	int buttonX; 
	int buttonY;
	boolean mouseOver;
	boolean open = false;

	Checkbox debugCb, debugMouseCb;

	Settings(int x, int y){
		buttonX = x;
		buttonY = y;
	}

	void setup(){
		debugCb = new Checkbox(140, 60, "Debug");
		debugMouseCb = new Checkbox(140, 80, "Debug Mouse");
	}

	void drawButton(){
		if(mouseOver) {
			//HSB();
			noStroke();
			//fill(hue(bgColor), saturation(bgColor), brightness(bgColor) - 20);
			fill(red(bgColor) - 50);
			rect(buttonX, buttonY, 25, 25);
		}
		if(!open) {
			image(settingsIcon, width - 30, 5);
		} else {
			stroke(0);
			strokeWeight(2);
			line(370, 5, 395, 30);
			line(395, 5, 370, 30);
		}
	}

	void update(){
		debug = debugCb.checked;
		debugMouse = debugMouseCb.checked;

		if(mouseX > 370 && mouseY < 30) {
			settings.mouseOver = true;
		} else {
			mouseOver = false;
		}
	}
	void show(){
		textAlign(CENTER, BOTTOM);
		textSize(20);
		fill(255);
		text("Developer Options", 200, 30);
		debugCb.update();
		debugCb.show();
		debugMouseCb.update();
		debugMouseCb.show();
	}
}
//	TODO add more tabs and ability to have more tabs
//	TODO add a type of dropdown menu or somethings to select the COM port
//	TODO Add a soundmultiplier option