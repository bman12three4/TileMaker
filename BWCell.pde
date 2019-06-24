class BWCell {

  int pos;
  boolean colored = false;

  BWCell(int x, boolean z) {
    pos = x;
    colored = z;
  }

  color getColor() {
    if (colored)
      return color(255, 255, 255);
    return color(0, 0, 0);
  }

  void setColor(int col) {
    colored = col == 1;
  }

  int getBit() {
    if (colored)
      return 1;
    return 0;
  }

  int getPos() {
    return pos;
  }
}