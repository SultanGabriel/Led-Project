boolean musicSinced = false;
boolean randomSync = false;
boolean colorSync = false;
boolean fade = false;
boolean fadetorandom = false;
//arduino settings
boolean outputEnable = true;
int baudrate = 250000;
String COM = "COM3";
//debug !
boolean debug = false;
boolean debugMouse = true;
//app colors
color bgColor = color(144, 178, 178);
color sidebarColor = color(0, 50);
color topbarColor = color(0, 50);
//soundmultiplier
int soundMultiplier = 20;
//default Color ; the color the app starts with
color defaultColor = color(255, 0, 0);
//icons
String settingsIconPATH = "./resources/settings.png";
String iconPATH = "./resources/icon.png";
//
color black = color(0);
/*
   int r = (c >> 16) & 0xFF;
   int g = (c >> 8) & 0xFF;
   int b = c & 0xFF;
   println("r" + r + " g" + g + " b" + b);

 */
