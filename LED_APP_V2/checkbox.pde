public class Checkbox { //TODO this needs some touching up!!
	int x, y;
	int size = 10;
	int hSize = int(size / 2);
	boolean mOver = false;
	boolean checked = false;
	String label;

	boolean textRect = false;

	Checkbox cb;
	boolean gotCB = false;
	boolean cbChecked = true;

	Checkbox(int x_, int y_, String label_) {
		x = x_;
		y = y_;
		label = label_;
	}

	Checkbox(int x_, int y_, String label_, Checkbox cb_) {
		gotCB = true;
		cb = cb_;
		x = x_;
		y = y_;
		label = label_;
	}

	void show() {
		RGB();
		textAlign(LEFT, BASELINE);
		textSize(size * 1.25);
		if (cbChecked) {
			stroke(0);
			strokeWeight(1);
			fill(255);
			rect(x - 0.5 * size, y - 0.5 * size, size, size);

			if (textRect) {
				int z = floor(textWidth(label));
				rect(x + hSize + 2, y - hSize - 2, z + 4, size + 4);
			}

			if (checked) {
				noStroke();
				fill(255, 0, 0);
				rect(x - 0.5 * size + size * 0.16, y - hSize + size * 0.16, size * 0.7, size * 0.7);
			}

			noStroke();
			fill(0);
			text(label, x + size * 0.5 + 5, y + hSize);
		}
	}

	int ml;

	void update() {
		if (gotCB) {
			cbChecked = cb.checked;

		} else {
			cbChecked = true;

		}

		int mx = mouseX;
		int my = mouseY;

		mOver = false;
		if (x - size / 2 < mx && x + size / 2 > mx &&
		    y - size / 2 < my && y + size / 2 > my) {
			mOver = true;
		}

		if (mOver && mousePressed && ml + 100 < millis() ) {
			checked = !checked;
			ml = millis();
		}
		this.show();
	}
}
