class Start extends DungeonTile {
	Start(String symbol, int r, int c) {
		super(symbol, r, c);
	}
  int getTileColor() {
    return color(30,100,30);
  }
}