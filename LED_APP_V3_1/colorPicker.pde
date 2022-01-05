/**
  * Color Wheel 
  */
class Picker {
    float x;
    float y;
    float radius;
    float wdh; // width
    float inc = TWO_PI / 180;
    float currentHue = 0;// = - 75;
    color currentColor;
    
    float angle = 0;
    int currentBrightness = int(vBrightnessSlider.value);
    
    Picker(float _x, float _y, float _radius, float _width) {
        x = _x;
        y = _y;
        wdh = _width;
        radius = _radius - _width;
    }
    
    void select(int mX, int mY) {
        color pickedColor = get(mX, mY);
        currentHue = hue(pickedColor);
        
        HSB();
        currentColor = color(currentHue, 100, currentBrightness);
        // RGB();
        
        angle = degrees(atan(mY / mX)); 
        
        if (debug) {
            String hexColorRGB = hex(currentColor).substring(2, 8);
            
            println("Current Color: " + hexColorRGB);
            
        }
    }
    
    void updateBrightness() {
        currentBrightness = int(vBrightnessSlider.value);
        currentColor = color(currentHue, 100, currentBrightness);
    }
    
    float cx, cy;
    void drawPicker() { 
        HSB();
        strokeWeight(1);
        
        // for(float i = 0; i < TWO_PI; i += increment) {
        //  int h = round(map(i, 0, TWO_PI, 0, 360));
        //  stroke(h, 100, currentBrightness);
        //  arc(x, y, radius, radius, i, i + increment);
    //}
        
        float vx;
        float vy;
        
        beginShape(TRIANGLE_STRIP);
        
        for (float i = 0; i <= TWO_PI; i += inc) {
            float h = map(i, 0, TWO_PI, 0, 360);
            
            fill(h, 100, currentBrightness);
            stroke(h,100, currentBrightness);
            
            vx = radius * cos(i) + x;
            vy = radius * sin(i) + y;
            vertex(vx, vy);
            
            vx = (radius - wdh) * cos(i) + x;
            vy = (radius - wdh) * sin(i) + y;
            vertex(vx, vy);
        }
        
        vx = radius * cos(- inc) + x;
        vy = radius * sin(- inc) + y;
        vertex(vx, vy);
        
        endShape();


		drawColorTriangle(x,y, 100);        
    }
}

void drawColorTriangle(float offx, float offy, int radius) {
	float a1 = PI;//HALF_PI; //
    float x1 = radius * sin(a1) + offx;
    float y1 = radius * cos(a1) + offy;

    float a2 = radians(300);//210
    float x2 = radius * sin(a2) + offx;
    float y2 = radius * cos(a2) + offy;

    float a3 = radians(60);//330
    float x3 = radius * sin(a3) + offx;
    float y3 = radius * cos(a3) + offy;
    
    //triangle(x1,y1,x2,y2,x3,y3);
    
    beginShape();
    
    fill(c);
    vertex(x1, y1);
    fill(0, 0, 0);
    vertex(x2, y2);
    fill(0, 0, 100);
    vertex(x3, y3);
    fill(c);
    vertex(x1, y1);
    
    endShape();

	strokeWeight(5);
	stroke(0);
	point(x1,x2);
}