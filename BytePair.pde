class BytePair { //<>//

  int field;
  boolean fieldSet;
  int x;
  int y;
  int hb1;
  int hb2;

  ArrayList<Cell> cells;
  ArrayList<BWCell> bwcells;

  BytePair(int x, int y, int hb1, int hb2) {
    this.x = x;
    this.y = y;
    this.hb1 = hb1;
    this.hb2 = hb2;

    cells = new ArrayList<Cell>();
    bwcells = new ArrayList<BWCell>();

    for (int i = 0; i < 7; i++) {
      Cell c;
      c = new Cell(0, i);
      cells.add(c);
      dupdate(c);
    }

    for (int i = 0; i < 14; i++) {
      BWCell bwc;
      bwc = new BWCell(i, false);
      bwcells.add(bwc);
      if (TileMaker.bw)
        bwdupdate(bwc);
    }
  }

  void update() {
    if (!TileMaker.bw) {
      for (Cell c : cells) {
        if (mouseX >= 560*x+c.getPos()*80 && mouseX < 560*x+(c.getPos()+1)*80 &&
          mouseY >= y*40 && mouseY < (y+1)*40 &&
          mousePressed) {
          if (!fieldSet) {
            fieldSet = true;
            field = TileMaker.field;
            updateField();
          }
          if (field == TileMaker.field)
            c.setColor(field*4 + TileMaker.col);
          dupdate(c);
        }
      }
    } else {
      for (BWCell bwc : bwcells) {
        if (mouseX >= 560*x+bwc.getPos()*40 && mouseX < 560*x+(bwc.getPos()+1)*40 &&
          mouseY >= y*40 && mouseY < (y+1)*40 &&
          mousePressed) {
          bwc.setColor(TileMaker.col);
          bwdupdate(bwc);
        }
      }
    }
  }

  void dupdate(Cell c) {
    fill(c.getColor());
    rect(560*x+c.getPos()*80, y*40, 80, 40);
  }

  void bwdupdate(BWCell bwc) {
    fill(bwc.getColor());
    rect(560*x+bwc.getPos()*40, y*40, 40, 40);
  }

  void updateField() {
    hb1 = field;
    hb2 = field;

    int lcol = 0;
    print(lcol + "    ");
    for (Cell c : cells) {
      lcol = c.getTC();
      if (field == 0) {
        print(lcol + "  ");
        if (lcol > 3) {
          lcol-=4;
          c.setColor(lcol);
        }
        println(lcol);
        dupdate(c);
      }
      if (field == 1) {
        if (lcol < 3) {
          lcol+=4;
          c.setColor(lcol);
        }
        println(lcol);
        dupdate(c);
      }
    }
  }

  String[] compute() {
    if (TileMaker.bw)
      return bwcompute();
    return colorcompute();
  }

  String[] colorcompute() {
    String b = "";
    b+=hb1;
    b+=cells.get(3).hb;
    for (int i = 2; i >-1; i--) {
      b+=cells.get(i).lb;
      b+=cells.get(i).hb;
    }

    String c = "";
    c+=hb2;
    for (int i = 6; i >3; i--) {
      c+=cells.get(i).lb;
      c+=cells.get(i).hb;
    }
    c+=cells.get(3).lb;

    println(b);
    println(c);

    String[] nums = new String[2];

    nums[0] = Integer.toHexString(Integer.parseInt(b, 2));
    nums[1] = Integer.toHexString(Integer.parseInt(c, 2));
    return nums;
  }

  String[] bwcompute() {

    String b = "";
    b+=0; // High bit is always 0
    for (int i = 6; i >= 0; i--) {
      b+=bwcells.get(i).getBit();
    }
    
    String c = "";
    c+=0; // High bit is always 0
    for (int i = 15; i <= 7; i--){
     c+=bwcells.get(i).getBit(); 
    }
    
    String[] nums = new String[2];
    nums[0] = Integer.toHexString(Integer.parseInt(b, 2));
    nums[1] = Integer.toHexString(Integer.parseInt(c, 2));
    return nums;
  }
}