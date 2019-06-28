class Cell {

  static final int BLACK = 0;
  static final int GREEN = 1;
  static final int PURPLE = 2;
  static final int WHITE = 3;
  static final int BLACK2 = 4;
  static final int ORANGE = 5;
  static final int BLUE =  6;
  static final int WHITE2 = 7;
 
  int tc;
  color col;
  int pos;

  public int lb;
  public int hb;

  Cell(int tcol, int pos) {
    tc = tcol;
    if (tcol == BLACK || tcol == BLACK2) {
      lb = 0;
      hb = 0;
      col = color(0, 0, 0);
    }
    if (tcol == GREEN) {
      lb = 1;
      hb = 0;
      col = color(0, 255, 0);
    }
    if (tcol == PURPLE) {
      lb = 0;
      hb = 1;
      col = color(255, 0, 255);
    }
    if (tcol == WHITE || tcol == WHITE2) {
      lb = 1;
      hb = 1;
      col = color(255, 255, 255);
    }
    if (tcol == ORANGE) {
      lb = 1;
      hb = 0;
      col = color(255, 171, 0);
    }
    if (tcol == BLUE) {
      lb = 0;
      hb = 1;
      col = color(0, 0, 255);
    }
    this.pos = pos;
  }

  color getColor() {
    return col;
  }
  
  int getTC(){
    return tc;
  }

  void setColor(int tcol) {
    tc = tcol;
    if (tcol == BLACK) {
      lb = 0;
      hb = 0;
      col = color(0, 0, 0);
    }
    if (tcol == BLACK2) {
      lb = 0;
      hb = 0;
      col = color(40, 40, 40);
    }
    if (tcol == GREEN) {
      lb = 1;
      hb = 0;
      col = color(0, 255, 0);
    }
    if (tcol == PURPLE) {
      lb = 0;
      hb = 1;
      col = color(255, 0, 255);
    }
    if (tcol == WHITE) {
      lb = 1;
      hb = 1;
      col = color(230, 230, 230);
    }
    if (tcol == WHITE2) {
      lb = 1;
      hb = 1;
      col = color(255, 255, 255);
    }
    if (tcol == ORANGE) {
      lb = 1;
      hb = 0;
      col = color(255, 171, 0);
    }
    if (tcol == BLUE) {
      lb = 0;
      hb = 1;
      col = color(0, 0, 255);
    }
  }

  int getPos() {
    return pos;
  }
}