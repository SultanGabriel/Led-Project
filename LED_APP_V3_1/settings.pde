class Settings { //TODO ADD MORE OPTIONS
	int buttonX; //Add a music random color change threshold
	int buttonY;
	boolean mouseOver;
	boolean open = false;
	
	Checkbox debugCb, debugMouseCb;
	
	Settings(int x, int y) {
		buttonX = x;
		buttonY = y;
	}
	
	void setup() {
		debugCb = new Checkbox(85, 70, "Debug");
		debugMouseCb = new Checkbox(85, 90, "Debug Mouse");
	}
	
	void drawButton() {
		if (mouseOver) {
			noStroke();
			fill(color(0, 35));
			rect(width - 35, 5, 30, 30);
		}
		
		stroke(0);
		strokeWeight(3);
		
		line(width - 30, 13, width - 10, 13);
		line(width - 30, 19, width - 10, 19);
		line(width - 30, 25, width - 10, 25);
	}
	
	void update() {
		debug = debugCb.checked;
		debugMouse = debugMouseCb.checked;
		
		if (mouseX > width - 40 && mouseY < 40) {
			settings.mouseOver = true;
		} else {
			mouseOver = false;
		}
	}

	void show() {
		textAlign(LEFT, BOTTOM);
		textSize(20);
		fill(0);
		text("Settings", 120, 30);
		
		textAlign(LEFT, BOTTOM);
		textSize(14);
		text("Debuging", 75, 50);

		debugCb.update();
		debugCb.show();
		debugMouseCb.update();
		debugMouseCb.show();

		fill(0);
		textSize(14);
		text("Random Change Threshold", 75, 120);
		thresholdSlider.update();

	}
}
//	TODO add more tabs and ability to have more tabs
//	TODO add a type of dropdown menu or somethings to select the COM port
//	TODO Add a soundmultiplier option