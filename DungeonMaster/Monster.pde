class Monster extends DungeonTile {
	Monster(String symbol, int r, int c) {
		super(symbol, r, c);
	}
  int getTileColor() {
    return color(100,10,30);
  }
}