class Trap extends DungeonTile {
	Trap(String symbol, int r, int c) {
		super(symbol, r, c);
	}
  int getTileColor() {
    return color(100,100,30);
  }
}