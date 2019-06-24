ArrayList<BytePair> pairs;

public static int field = 0;
public static int col = 1;
public static boolean bw = true;

int w = 2; // this is for color so its actually 4 bytes wide
int h = 3;

public static int scale = 30;

void setup() {
  int wdth = (w*14*scale)+100;
  int hght = h*8*scale;
  surface.setResizable(true);
  surface.setSize(wdth, hght);
  surface.setResizable(false);
  pairs = new ArrayList<BytePair>();
  for (int i = 0; i < h*8; i++) {
    for (int j = 0; j < w; j++) {
      BytePair p = new BytePair(j, i, 0, 0);
      pairs.add(p);
    }
  }
}

void draw() {
  for (BytePair p : pairs) {
    p.update();
    updateButtons();
  }
}

void updateButtons() {

  int rightSide = (w*14*scale)+10;

  fill(255, 255, 255);
  rect(rightSide-10, 0, width, height);
  fill(200, 200, 200);
  rect(rightSide, 35, 80, 20);
  fill(0, 0, 0);
  text("Save", rightSide+10, 50);

  if (!bw) {
    fill(200, 200, 200);
    rect(rightSide, 65, 80, 20);
    fill(0, 0, 0);
    text("Field   " + field, rightSide+10, 80);
  }

  fill(200, 200, 200);
  rect(rightSide, 95, 80, 20);
  fill(0, 0, 0);
  text("Color  " + col, rightSide+10, 110);

  fill(200, 200, 200);
  rect(rightSide, 125, 80, 20);
  fill(0, 0, 0);
  text("BW?  " + bw, rightSide+10, 140);
}

void mouseClicked() {
  int rightSide = (w*14*scale)+10;
  if (mouseX>rightSide+10) {
    if (mouseY>35 && mouseY < 55)
      compute();
    if (mouseY>65 && mouseY < 85) {
      if (field == 0) {
        field = 1;
      } else {
        field = 0;
      }
    }
    if (mouseY>95 && mouseY < 115) {
      if (!bw) {
        if (col > 2) {
          col = 0;
        } else {
          col++;
        }
      } else {
        if (col > 0) {
          col = 0;
        } else {
          col++;
        }
      }
    }
    if (mouseY>125 && mouseY < 145) {
      if (bw) {
        bw = false;
      } else {
        bw = true;
      }
    }
  }
}

void compute() {
  String f = "";
  for (int i = 0; i < 32; i+=2) {
    String o = ".byte ";
    String[] nums = pairs.get(i).compute();
    String[] nums2 = pairs.get(i+1).compute();
    o += "$";
    o += nums[0];
    o += ", $";
    o += nums[1];
    o += ", $";
    o += nums2[0];
    o += ", $";
    o += nums2[1];
    f+=o;
    f+="\n";
  }
  println(f);
}