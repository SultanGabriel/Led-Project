dropdownMenu ddM;

void setup() {
    size(500,500);
    ddM = new dropdownMenu(50, 50, 3);
    ddM.addOption(0, "ONE", "optionOne");
    ddM.addOption(1, "TWO", "optionTwo");
    ddM.addOption(2, "THREE", "optionThree");
}

void draw() {
    background(220);
    ddM.update();
}

void optionOne() {
    println("ONE");
}

void optionTwo() {
    println("TWO");
}

void optionThree() {
    println("THREE");
}

void mousePressed() {
    
}

class dropdownMenu{
    int x, y;
    int w = 100,
    h = 25;
    
    int numOfOptions;
    
    Option[] options;
    boolean optionsOpen = false;
    
    int indexSelectedOption = 0;
    
    int backgroundColor = color(255);
    int textColor = color(0);
    int fontSize = 14;
    
    dropdownMenu(float _x, float _y, int _numOfOptions) { 
        x = int(_x);
        y = int(_y);
        numOfOptions = _numOfOptions;
        options = new Option[_numOfOptions];
    }
    
    void addOption(int index,String label, String callback) {
        options[index] = new Option(index, label, callback);
    }
    
    void show() {
        fill(backgroundColor);
        rect(x, y, w, h);
        fill(textColor);
        textSize(fontSize);
        text(options[indexSelectedOption].label, x + 2, y + h - 3);
        
        if (optionsOpen) {
            drawOptions();
        }
    }
    
    void update() {
        this.show();

        if (this.isOver(mouseX, mouseY)) {
            backgroundColor = color(200);
            if (mousePressed) {
                this.clicked();
            }
        }else{
            backgroundColor = color(255);
        }
    }
    
    void openOptions() {
        optionsOpen = !optionsOpen;
    }
    
    void drawOptions() {
        for (int i = 0; i < numOfOptions; i++) {
            if (i != indexSelectedOption) {
                String label = options[i].label;
                if(i == 0){
                    drawOption(x, y + h, label);
                }else{
                    drawOption(x, y + (h + 2) * i, label);
                }
            }
        }
    }
    
    void drawOption(int x, int y, String label) {
        // println("x " + x + " y " + y + " label " + label);
        fill(backgroundColor);
        rect(x,y, w, h);
    }
    
    boolean isOver(float mx, float my) {
        return(x + w >= mx && mx >= x) && (y + h >= my && my >= y);
    }
    
    void clicked() {
        this.openOptions();
        // options[indexSelectedOption].callback();
        //backgroundColor = color(random(255), random(255), random(255));
    }
}
// Data Class for the Options
class Option{
    String label, callbackFunction;
    int index; 
    
    Option(int _index, String _label, String _callback) {
        index = _index;
        label = _label;
        callbackFunction = _callback;
    }
    
    void callback() {
        method(this.callbackFunction);
    }


}