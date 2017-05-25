abstract class DungeonTile {
  String symbol;
  int row;
  int col;

  public DungeonTile(String symbol, int r, int c) {
    this.symbol = symbol;
    row = r;
    col = c;
  }

  int row() {
    return row;
  }

  int col() {
    return col;
  }

  abstract int getTileColor();
  String getTileText() { return symbol; }
}
