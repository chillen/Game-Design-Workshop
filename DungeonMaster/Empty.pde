class Empty extends DungeonTile {
	Empty(String symbol, int r, int c) {
		super(symbol, r, c);
	}
  int getTileColor() {
    return color(200,200,200);
  }
  String getTileText() { return ""; }
}
