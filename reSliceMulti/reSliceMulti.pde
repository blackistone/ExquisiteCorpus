// RESLICES A VERTICAL IMAGE STACK TO ONE BASED ON DEPTH
// directory is not iterated to keep files in numeric order
// commented  out areas are for showing result

import java.util.Iterator;

PImage src;
PImage[] nuStack;
String[] imageFilenames;


int slices =0;
char axis = 1;


String subD = "";
String prefix = "";
int padding = 4;
String extension = ".png";

boolean scaleOutput = false;
int outX = 512, outY = 768;


void setup() {

  reSlice("006/", 512);
  reSlice("009/", 512);
  reSlice("058/", 512);
  reSlice("063/", 512);
  reSlice("081/", 512);
  reSlice("085/", 512);
  reSlice("127/", 512);
  reSlice("183/", 512);
  reSlice("241/", 512);
  reSlice("266/", 512);
  reSlice("298/", 512);
  reSlice("305/", 512);
  
  
  println("DONE");

  int secs = millis()/1000;
  int hrs = secs/3600;
  int min = (secs - (hrs * 3600)) / 60;
  int sec = secs - (hrs * 3600) - (min * 60);

  println("Completed! TRT: " + nf(hrs, 2) + ":" + nf(min, 2) + ":" + nf(sec, 2));

  exit();
}

void reSlice(String PATH, int frames) {

  PImage[] srcStack = new PImage[frames];

  String pth = PATH + prefix +nf(0, padding) + extension;
  println("REMEMBER START FRAME MUST BE 0!");
  println("Loading from:", pth);
  src = loadImage(pth);
  if (axis == 1) slices = src.height;
  else exit(); // slices = src.width;

  println(slices + " new slices will be " + src.width + "w x " + frames + "h");
  nuStack = new PImage[slices];


  for (int i = 0; i < slices; i++) {
    nuStack[i] = createImage(src.width, frames, ARGB);
  }

  for (int z = 0; z < frames; z++) {

    pth = PATH + prefix + nf(z, padding) + extension;
    println(pth);
    src = loadImage(pth);
    srcStack[z] = src;

    src.loadPixels();
    for (int y = 0; y < src.height; y++) {
      nuStack[y].loadPixels();
      for (int x = 0; x < src.width; x++) {
        color pix = src.pixels[y * src.width + x];
        nuStack[y].pixels[z * src.width + x] = pix;
      }
      nuStack[y].updatePixels();
    }
  }
  print("SAVEING!...");
  for (int i = 0; i < nuStack.length; i++) {
    if (scaleOutput) nuStack[i].resize(outX,outY);
    nuStack[i].save("resliced/" + PATH + nf(i, padding) + ".png");
  }

  int secs = millis()/1000;
  int hrs = secs/3600;
  int min = (secs - (hrs * 3600)) / 60;
  int sec = secs - (hrs * 3600) - (min * 60);

  println("PATH RUNTIME: " + nf(hrs, 2) + ":" + nf(min, 2) + ":" + nf(sec, 2));
}
