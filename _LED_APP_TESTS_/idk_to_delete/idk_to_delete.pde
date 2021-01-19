String input = "jU5t_a_sna_3lpm18gb41_u_4_mfr340";
String answer = "";
void setup() {
  size(100, 100);

  char[] buffer = new char[32];

  int i;

  for (i=0; i<8; i++) {
    buffer[i] = input.charAt(i);
  }
  for (; i<16; i++) {
    buffer[i] = input.charAt(23-i);
  }
  for (; i<32; i+=2) {
    buffer[i] = input.charAt(46-i);
  }
  for (i=31; i>=17; i-=2) {
    buffer[i] = input.charAt(i);
  }

  String s = new String(buffer);
  println(s);

  noLoop();
}

void draw() {
}

public void whenGetBytesWithCharset_thenOK() {
    String inputString = "Hello ਸੰਸਾਰ!";
    //Charset charset = Charset.forName("ASCII");

      byte[] byteArrray = charset.encode(inputString).array();
  println(byteArrray);
}
