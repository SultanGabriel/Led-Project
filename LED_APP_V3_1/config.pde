boolean musicSinced = false;
boolean randomSync = false;
boolean colorSync = false;
boolean fade = false;
boolean fadetorandom = false;

boolean secondaryLights = false;
// boolean updateSecodaryLights = false;
//arduino settings
boolean outputEnable = false;
int baudrate = 500000;
String COM = "COM3";
//debug !
boolean debug = false;
boolean debugMouse = false;
//app colors
color bgColor = color(175, 175, 192);
color sidebarColor = color(0, 50);
color topbarColor = color(0, 50);
//soundmultiplier
int soundMultiplier = 20;
//random color change threshold
float rColorSwitchThr = 500;

//default Color ; the color the app starts with
color defaultColor = color(255, 0, 0);
//icons
String settingsIconPATH = "./resources/settings.png";
String iconPATH = "./resources/icon.png";

//
color black = color(0);


//Current Color mode RGB ?
boolean rgbBool = true;

/*
   int r = (c >> 16) & 0xFF;
   int g = (c >> 8) & 0xFF;
   int b = c & 0xFF;
   println("r" + r + " g" + g + " b" + b);

 */
