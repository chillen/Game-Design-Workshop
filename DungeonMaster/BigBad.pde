class BigBad  extends DungeonTile {
	BigBad (String symbol, int r, int c) {
		super(symbol, r, c);
	}
  int getTileColor() {
    return color(120,90,20);
  }
}