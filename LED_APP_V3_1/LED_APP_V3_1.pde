Checkbox cbSynced, cbRandom, cbColorSync, cbFade, cbFadeToRandom, cbSecLights;
Slider thresholdSlider,fadeSpeedSlider, brightnessSlider, vBrightnessSlider; // VERTICAL SLIDER
Picker picker;
Settings settings;

//  IDEA darkmode option
//  IDEA customisable background color
// 	IDEA huesync mode > the hue of the color and sound of the music sync
//  IDEA dynamic randomThreshold .  
//  <-- SETTINGS -->
//  TODO add COM Port selection
//  TODO save setting in config

//  FIXME App crashing when no serial port found 
//                      ==> Error + Dropdown to change port


//	BUG LIGHTS FLICKERING AT SOME BRIGHTNESS LEVELS
//	BUG OPENING SETTINGS CHANGES COLOR !!!!!!!!!


//  WIP .. Redesigning GUI 
//  DOING Redesigning Color Picker
//  IDEA DropDown Menu for modes...
//  	IDEA Rename: Color; fade; Color Sync; Single Color Sync; Random Sync; 
//  TODO change bg color
//  TODO redesign checkboxes
// 	TODO ADD TURN OFF FUNCTIONALITY

void setup() {
    size(400, 500, P2D);
    // Set window icon..
    setIcon();
    // initializing the sound module
    minim = new Minim(this);
    getMixer();
    player = minim.getLineIn();
    // connect to Arduino
    if (outputEnable) {
        connectToArd();
    };
    
    settings = new Settings(width - 30, 5);
    settings.setup();
    
    //random color change threshold
    thresholdSlider = new Slider(50, 135, 300, 100, 1000, 750);
    thresholdSlider.id = "Random Color Change Threshold";
    
    //fade speed
    fadeSpeedSlider = new Slider(50, 150, 300, 0.01, 2, 0.5);
    fadeSpeedSlider.id = "Fade Speed";
    
    //Brightness
    brightnessSlider = new Slider(50, 100, 300, 0, 100, 50);
    brightnessSlider.id = "Brightness";
    brightnessSlider.dotColor = color(255);
    
    vBrightnessSlider = new Slider(40, 440, 300, 0, 100, 100);
    vBrightnessSlider.id = "Brightness Slider";
    vBrightnessSlider.dotColor = color(255);
    vBrightnessSlider.callback = true;
    vBrightnessSlider.callbackFunction = "updateBrightnessCallback";
    
    //>>>>>>>>>>>>>>>Checkboxes<<<<<<<<<<<<<<<<<<
    
    cbSynced = new Checkbox(75, 20, "Sync to music");
    cbRandom = new Checkbox(75, 35, "Random", cbSynced);
    //cbColorSync = new Checkbox(75, 50, "Hue", cbSynced);
    
    cbFade = new Checkbox(225, 20, "Fade");
    cbFadeToRandom = new Checkbox(225, 40, "Fade to Random");
    
    //Checkbox for secondary lights
    cbSecLights = new Checkbox(75, 50, "Secondary Lights");
    //set callback function
    cbSecLights.callback = true;
    cbSecLights.callbackFunction = "secLightsCallback";
    
    //picker
    picker = new Picker(200, 250, 180, 35);
    picker.currentColor = defaultColor;
}

color c;
color selectedColor;

void draw() {
    // RGB();
    background(bgColor);
    
    cbSynced.update();
    cbRandom.update();
    //cbColorSync.update();
    cbFade.update();
    cbFadeToRandom.update();
    
    cbSecLights.update();
    
    if (!settings.open) {
        cbSynced.show();
        cbRandom.show();
        
        
        cbFade.show();
        cbFadeToRandom.show();
        
        cbSecLights.show();
        
    }
    
    //TODO the random and hue checkboxes should not be able to be checked at the same time
    
    randomSync = cbRandom.checked;
    musicSinced = cbSynced.checked;
    //colorSync = cbColorSync.checked;
    fade = cbFade.checked;
    fadetorandom = cbFadeToRandom.checked;
    
    
    
    rColorSwitchThr = thresholdSlider.value;
    
    settings.update();
    settings.drawButton();
    
    if (settings.open) {
        settings.show();
    } else if (!fade && !colorSync && !fadetorandom) {
        
        vBrightnessSlider.update();
        picker.drawPicker();
    } else if (fade || fadetorandom) {
        fadeSpeedSlider.update();
        brightnessSlider.update();
    }
    
    //sliderColor = color(sliders[0].value, sliders[1].value, sliders[2].value);
    selectedColor = picker.currentColor;
    
    // TODO REWRITE THE MODE SELECTOR ( USE SWITCH )
    if (musicSinced && !colorSync && !randomSync) {   //SYNC ONE COLOR
        c = musicOneColor(selectedColor);
        sendToArd(c);
    } else if (musicSinced && colorSync && !randomSync) {    //COLOR SYNC
        float br = brightnessSlider.value;
        c = musicColorSynced(br);
        sendToArd(c);
    } else if (musicSinced && !colorSync && randomSync) {    //RANDOM SYNC
        c = musicRnd();
        sendToArd(c);
    } else if (fade) {    //FADE
        float br = brightnessSlider.value;
        float speed = fadeSpeedSlider.value;
        c = fade(speed, br);
        sendToArd(c);
    } else if (fadetorandom) {
        float br = brightnessSlider.value;
        float speed = fadeSpeedSlider.value;
        c = fadeToRandom(c, speed, br);
        sendToArd(c);
    } else if (c != selectedColor) {
        sendToArd(selectedColor);
        c = selectedColor;
    }
    
    if (debugMouse) {
        text(mouseX + ", " + mouseY, mouseX + 5, mouseY - 5);
        stroke(255, 0, 0);
        line(mouseX, 0, mouseX, height);
        line(0, mouseY, width, mouseY);
    }
    
}

void keyPressed() {
    if (key == 'w') {
        println(picker.currentHue);
    }
}
// Callback Functions

void secLightsCallback() {
    //SECONDARY LIGHTS STATUS
    secondaryLights = cbSecLights.checked;
    sendToArdSecColor(secondaryLights);
}
void updateBrightnessCallback() {
    picker.updateBrightness();
}

// Helper Functions

void HSB() {
    if (rgbBool) {
        colorMode(HSB, 360, 100, 100);
        rgbBool = false;
    }
}
void RGB() {
    if (!rgbBool) {
        colorMode(RGB, 255, 255, 255);
        rgbBool = true;
    }
}
