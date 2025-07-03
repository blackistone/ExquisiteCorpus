
PImage img;


String subD = "interpolated_frames";

String prefix = "frame_";
String nuPre = "";
int padding = 3;
int nuPad = 4;
String extension = ".png";

void setup() {

  split4("015", "032");
  
  int secs = millis()/1000;
  int hrs = secs/3600;
  int min = (secs - (hrs * 3600)) / 60;
  int sec = secs - (hrs * 3600) - (min * 60);

  println("Completed! TRT: " + nf(hrs, 2) + ":" + nf(min, 2) + ":" + nf(sec, 2));
  // testImage.resize(1024, 0);
  exit();
}

void split4(String one, String two) {

  String subsubD = one + "-" + two + "/";
  String subD1 = one + "+" + two;
  //String subD1 = "1";
  //String subD2 = "2";
  int startFrame = 1;

  File dir = new File(sketchPath(subsubD + subD));
  println(dir.getAbsolutePath());
  File[] files = dir.listFiles();
  int length = files.length;

  String path;
  String outD="";

  println(length, "Files");
  for ( int i=startFrame; i < length; i++ ) {

    path = sketchPath() + "/" + subsubD + subD + "/" + prefix + nf(i, padding) + ".png";
    if (i%2 == 0) {
      println("Excluding:" + prefix + nf(i, padding) + extension);
      continue;
    } else if (i%4 == 1) outD = subD1;
    else if (i%4 == 3) {

      println("Excluding:" + prefix + nf(i, padding) + extension);
      continue;
    } // outD = subD2;

    img = loadImage(path);

    //  String outpath = sketchPath() + subsubD + outD + "/" + nuPre + nf(floor(i/4), nuPad) + ".png";
    String outpath = sketchPath() + "/" + outD + "/" + nuPre + nf(floor(i/4), nuPad) + ".png";
    println(outpath);

    img.save(outpath);
    println("copied:" + path + " to ", outpath);
  }
}
