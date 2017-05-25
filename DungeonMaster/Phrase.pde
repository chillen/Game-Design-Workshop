class Phrase {
  // STATS
  byte trait; // aggression? curiosity? greed? This is what's attractive
  int detectDC; // they must roll higher than this to see it. Lower is more obvious, louder, etc.
  String direction; // north, south, east, west

  // FLUFF
  String sentence;

  public Phrase(byte trait, int dc, String sentence) {
    this.trait = trait;
    this.detectDC = dc;
    this.sentence = sentence;
  }

  void setDirection(String direction) {
    this.direction = direction;
  }

  int getDC() { return detectDC; }
  byte getTrait() { return trait; }

  String toString() {
    return "(DC " + detectDC + ") To the " + direction + ", " + sentence;
  }
}
