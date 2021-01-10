Checkbox cbSynced, cbRandom, cbColorSync, cbFade, cbFadeToRandom, cbSecLights;
Slider thresholdSlider;
Slider fadeSpeedSlider, brightnessSlider;       //fadeBrightnessSlider
Slider vBrightnessSlider; // VERTICAL SLIDER
Picker picker;
Settings settings;
//  IDEA darkmode option
//  IDEA customisable background color
// 	IDEA huesync mode > the hue of the color and sound of the music sync

//  FIXME Catch errors on launch //the app stops responding, give the option to select the com port
//  TODO fix settings

//  TODO make the config a cfg or json
//  TODO add more settings!!
//  TODO better background
//  TODO better icon / logo

//  TODO add profiles tab
//  TODO ADD PROFILES

//  WIP .. Redesigning GUI 
//  TODO move sound threshold to settings
//  DOING move wheel on the left and adjust the Brightness slider
//  TODO change bg color
//  TODO redesign checkboxes
//  
void setup() {
  size(700, 400);
  surface.setResizable(true);
  surface.setTitle("LED Controller");
  setIcon();
  minim = new Minim(this);
  getMixer();
  player = minim.getLineIn();
  connectToArd();

  icon.resize(50, 50);

  //settingsIcon = loadImage(settingsIconPATH);
  //settingsIcon.resize(25, 25);

  settings = new Settings(width - 30, 5);
  settings.setup();

  //fade brightness
  // sliders[1] = new Slider(50, 100, 300, 0, 100, 25);
  // sliders[1].id = "Fade Brightness";
  // sliders[1].dotColor = color(255);

  //random color change threshold
  thresholdSlider = new Slider(15, 370, 300, 100, 1000, 750);
  thresholdSlider.id = "Random Color Change Threshold";

  //fade speed
  fadeSpeedSlider = new Slider(50, 150, 300, 0.01, 2, 0.5);
  fadeSpeedSlider.id = "Fade Speed";

  //Brightness
  brightnessSlider = new Slider(50, 100, 300, 0, 100, 50);
  brightnessSlider.id = "Brightness";
  brightnessSlider.dotColor = color(255);

  vBrightnessSlider = new Slider(15, 340, 300, 0, 100, 100);
  vBrightnessSlider.id = "Brightness Slider";
  vBrightnessSlider.dotColor = color(255);
  vBrightnessSlider.callback = true;
  vBrightnessSlider.callbackFunction = "updateBrightnessCallback";

  //vBrightnessSlider.vertical = true;

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
  picker = new Picker(200, 210, 200);
  picker.currentColor = defaultColor;
}

color c;
color selectedColor;

void draw() {
  RGB();
  background(bgColor);

  image(icon, 0, 0);
  drawRightMenuBar();
  cbSynced.update();
  cbRandom.update();
  //cbColorSync.update();
  cbFade.update();
  cbFadeToRandom.update();

  cbSecLights.update();
  thresholdSlider.update();
  vBrightnessSlider.update();

  if (!settings.open) {
    cbSynced.show();
    cbRandom.show();
    //cbColorSync.show();
    cbFade.show();
    cbFadeToRandom.show();

    cbSecLights.show();
    //thresholdSlider.show();
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

    picker.drawPicker();

    //sliders[5].update();
    //} else if(colorSync) {
    //	brightnessSlider.update();
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

  // 	slider for brightness position --
  // <<	line(330, 80, 330, 320);	>>
}
// Function for Callback property
void secLightsCallback() {
  //SECONDARY LIGHTS STATUS
  secondaryLights = cbSecLights.checked;
  sendToArdSecColor(secondaryLights);
}
void updateBrightnessCallback(){
  picker.updateBrightness();
}

// Helper Functions
void drawRightMenuBar() {
  noStroke();
  fill(sidebarColor);
  rect(400, 0, 300, height);
  fill(topbarColor);
  rect(400, 0, 300, 40);
}



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
