ArrayList<BytePair> pairs;

public static int field = 0;
public static int col = 1;
public static boolean bw = true;

int w = 2; // this is in color tiles, black and white tiles will be double this
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
  }

  updateButtons();

  for (int i = 1; i < w*2; i++) {
    fill (255, 0, 0);
    rect(i*scale*7, 0, 2, height);
  }

  for (int i = 1; i < h; i++) {
    fill (255, 0, 0);
    rect(0, i*scale*8, width-100, 2);
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

  fill(200, 200, 200);
  rect(rightSide, 155, 80, 20);
  fill(0, 0, 0);
  text("Invert", rightSide+10, 170);

  fill(200, 200, 200);
  rect(rightSide, 185, 80, 20);
  fill(0, 0, 0);
  text("Clear", rightSide+10, 200);
}

void keyPressed() {
  if (key == 'x' || key == 'X') {
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

    if (mouseY>155 && mouseY < 175) {
      for (BytePair p : pairs) {
        p.invert();
      }
    }
    if (mouseY>185 && mouseY < 205) {
      for (BytePair p : pairs) {
        p.reset();
      }
    }
  }
}

void compute() {
  String f = "";
  for (int i = 0; i < w*h*8; i+=w) {
    String o = ".byte ";
    String[][] nums = new String[w][2];
    nums[0] = pairs.get(i).compute();
    o += "$";
    o += nums[0][0];
    o += ", $";
    o += nums[0][1];
    for (int j = 1; j < w; j++) {
      nums[j] = pairs.get(i+j).compute();
      o += ", $";
      o += nums[j][0];
      o += ", $";
      o += nums[j][1];
    }
    f+=o;
    f+="\n";
  }
  println(f);
}