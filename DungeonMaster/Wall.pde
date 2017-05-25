class Wall extends DungeonTile {
	Wall(String symbol, int r, int c) {
		super(symbol, r, c);
	}
  int getTileColor() {
    return color(30,10,30);
  }
  String getTileText() { return ""; }
}