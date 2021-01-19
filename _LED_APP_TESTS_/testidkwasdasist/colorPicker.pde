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
        strokeWeight(1);
        
        // for(float i = 0; i < TWO_PI; i += increment) {
        //   inth = round(map(i, 0, TWO_PI, 0, 360));
        //   stroke(h, 100, currentBrightness);
        //   arc(x, y, radius, radius, i, i + increment);
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
            vertex(vx,vy);
            
            vx = (radius - wdh) * cos(i) + x;
            vy = (radius - wdh) * sin(i) + y;
            vertex(vx,vy);
        }
        
        vx = radius * cos(- inc) + x;
        vy = radius * sin(- inc) + y;
        vertex(vx, vy);
        
        endShape();
        
        // cx = round((radius) / 2 * cos(radians(currentHue)) + x);
        // cy = round((radius) / 2 * sin(radians(currentHue)) + y);
        
        //Drawing Triangle
        //int[] triangleVertices = {67, 0, - 33, 50, - 33, - 50, 67, 0};
        //int[] colors = {color(currentHue, 100, 50), color(0),  color(255), color(currentHue, 10,50)};
        //drawTriangleFromVertices(x, y, triangleVertices, currentHue, colors);
        
    }
}  

// int[] triangleVertices = {67, 0, - 33, 50, - 33, - 50, 67, 0};
// int[] colors = {color(currentHue, 100, 50), color(0),  color(255), color(currentHue, 10,50)};
void drawTriangleFromVertices(float posX, float posY, int[] vertices, float rotation, int[] colors) {
    pushMatrix();
    
    translate(posX, posY);
    rotate(radians(rotation));
    
    strokeWeight(2);
    stroke(0);
    
    beginShape();
    for (int i = 0; i < 4; i++) {
        fill(colors[i]);
        vertex(vertices[i], vertices[i + 1]);
    }
    endShape();
    
    popMatrix();
}
