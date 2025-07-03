// RESLICES A VERTICAL IMAGE STACK TO ONE BASED ON DEPTH
// directory is not iterated to keep files in numeric order
// commented  out areas are for showing result

import java.util.Iterator;
// import peasy.*;

PImage src;
PImage[] srcStack;
PImage[] nuStack;
String[] imageFilenames;

int points = 0;
int slices =0;
char axis = 1;

int frames = 344 ;
String subD = "2+4/";
String prefix = "";
int padding = 4;
String extension = ".png";

/* PeasyCam cam;
 float[] camPos;
 
 int spacing = 1;
 
 int zOffset = frames*spacing/2;
 float div = 10;
 
 void setup() {
 size(1024, 1024, P3D);
 
 noSmooth();
 hint(ENABLE_DEPTH_SORT);
 hint(DISABLE_DEPTH_TEST);
 hint(ENABLE_STROKE_PERSPECTIVE);
 
 cam = new PeasyCam(this, 600);
 cam.setMinimumDistance(200);
 cam.setMaximumDistance(1200);
 */

srcStack = new PImage[frames];

String pth = subD + prefix +nf(0, padding) + extension;
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

  pth = subD + prefix + nf(z, padding) + extension;
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

  nuStack[i].save("resliced/" + subD + nf(i, padding) + ".png");
}
println("DONE");
exit();


/* }
 
 void draw() {
 background(0);
 blendMode(ADD);
 tint(64, 64, 64, 6);
 stroke(0.5);
 for (int i = 0; i < nuStack.length; i++) {
 beginShape();
 texture(nuStack[i]);
 int z = i * spacing - zOffset;
 vertex(-256, -256, z + random(0), 0, 0);
 vertex( 256, -256, z + random(0), 512, 0);
 vertex( 256, 256, z + random(0), 512, frames);
 vertex(-256, 256, z + random(0), 0, frames);
 endShape();
 }
 
 surface.setTitle("Scene [FPS: " + String.format("%.2f", frameRate) + "]");
 }
 
 void keyPressed() {
 if (key == CODED) {
 if (keyCode == UP) {
 cam.setDistance(cam.getDistance()*.9);
 }
 if (keyCode == DOWN) {
 cam.setDistance(cam.getDistance()*1.11);
 }
 } else if (key == '2') stackOn = !stackOn;
 }
 */
