class Gear  extends DungeonTile {
	Gear (String symbol, int r, int c) {
		super(symbol, r, c);
	}
  int getTileColor() {
    return color(30,10,30);
  }
}
