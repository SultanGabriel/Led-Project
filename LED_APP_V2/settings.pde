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
			fill(color(0,50));
			rect(width - 30, 0, 30, 30);
		}
		stroke(0);
		strokeWeight(3);
		line(width - 40, 10, width - 10, 10);
		line(width - 40, 20, width - 10, 20);
		line(width - 40, 30, width - 10, 30);
		//image(settingsIcon, width - 30, 5);
	}

	void update(){
		debug = debugCb.checked;
		debugMouse = debugMouseCb.checked;

		if(mouseX > width - 40 && mouseY < 40) {
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