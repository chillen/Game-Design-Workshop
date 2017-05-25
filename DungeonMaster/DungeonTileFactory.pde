class DungeonTileFactory {
  DungeonTile get(String symbol, int r, int c) {
    switch (symbol.charAt(0)) {
      case 'M': // monster
        return new Monster(symbol, r, c);
      case 'S': // start
        return new Start(symbol, r, c);
      case 'G': // gear
        return new Gear(symbol, r, c);
      case 'W': // wall
        return new Wall(symbol, r, c);
      case 'T': // trap
        return new Trap(symbol, r, c);
      case 'B': // Big bad
        return new BigBad(symbol, r, c);
      default:
        return new Empty(symbol, r, c);
    }
  }
}
