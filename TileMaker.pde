ArrayList<BytePair> pairs;

public static int field = 0;
public static int col = 0;
public static boolean bw = true;

void setup() {
  size(1220, 640);
  pairs = new ArrayList<BytePair>();
  for (int i = 0; i < 16; i++) {
    for (int j = 0; j < 2; j++) {
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
  fill(255, 255, 255);
  rect(1120, 0, width, height);
  fill(200, 200, 200);
  rect(1130, 35, 80, 20);
  fill(0, 0, 0);
  text("Save", 1140, 50);

  if (!bw) {
    fill(200, 200, 200);
    rect(1130, 65, 80, 20);
    fill(0, 0, 0);
    text("Field   " + field, 1140, 80);
  }

  fill(200, 200, 200);
  rect(1130, 95, 80, 20);
  fill(0, 0, 0);
  text("Color  " + col, 1140, 110);

  fill(200, 200, 200);
  rect(1130, 125, 80, 20);
  fill(0, 0, 0);
  text("BW?  " + bw, 1140, 140);
}

void mouseClicked() {
  if (mouseX>1130) {
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