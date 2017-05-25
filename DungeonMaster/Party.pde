class Party {
  ArrayList<PartyMember> members;
  PVector position;
  private long moveTime;
  DungeonTile destinationTile;

  Party() {
    members = new ArrayList<PartyMember>();
    position = new PVector();
    moveTime = 0;
  }

  void start(int row, int col) {
    this.setGridPosition(row, col);
    this.updateTile();
  }

  void setGridPosition(int row, int column) {
    position.y = row * gridBoxSize() + gridBoxSize()/2;
    position.x = column * gridBoxSize() + gridBoxSize()/2;
  }

  Party setDestinationTile(DungeonTile tile) {
    this.destinationTile = tile;
    return this;
  }

  Party move() {
    if (this.destinationTile != null)
      moveTo(destinationTile.row(), destinationTile.col());
    return this;
  }

  Party moveTo(int row, int col) {
    long timestamp = millis();
    // if we're entering this for the first time, stamp
    if (moveTime == 0)
      moveTime = timestamp;
    // if we've moved forward, update our tile and quit
    if (inCenterOf(row, col)) {
      updateTile();
      moveTime = 0;
      return this;
    }
    // We're just moving normally here.
    // MOVE_SPEED is about how many seconds per tile we move
    if (timestamp - moveTime > (1000 * MOVE_SPEED) / gridBoxSize()) {
      moveTime = 0;
      if (movingDown(row))
        position.y++;
      if (movingUp(row))
        position.y--;
      if (movingRight(col))
        position.x++;
      if (movingLeft(col))
        position.x--;
    }

    return this;
  }

  void updateTile() {
    ArrayList<DungeonTile> openSet = new ArrayList<DungeonTile>();
    int[] traitScore = {0,0,0};


    // Check north
    if (! (row() - 1 < 0 || tile[row()-1][col()] instanceof Wall) ) {
      openSet.add(tile[row()-1][col()]);
    }

    if (!(row() + 1 == tile.length || tile[row()+1][col()] instanceof Wall)) {
      openSet.add(tile[row()+1][col()]);
    }

    if (!(col() - 1 < 0 || tile[row()][col()-1] instanceof Wall)) {
      openSet.add(tile[row()][col()-1]);
    }

    if (!(col() + 1 == tile[0].length || tile[row()][col()+1] instanceof Wall)) {
      openSet.add(tile[row()][col()+1]);
    }

    // if only one choice, go there
    if (openSet.size() == 1) {
      setDestinationTile(openSet.get(0));
    }

    if (openSet.size() == 0)
      println("FOO");

    // Roll for next room! But first, what if the DM was silent?
    if (chosenPhrases.size() == 0 && openSet.size() > 0) {
      int roll = (int) random(0, openSet.size());
      setDestinationTile(openSet.get(roll));
    }
    // Everybody rolls perception. This determines if they respond to the trigger
    // If they see it, they then add their modifier to the direction. The highest
    // wins. Not going to bother with init yet.
    else {
      println(getSize());
      int[] rolls = new int[getSize()];
      println("ROLL FOR PERCEPTION! " + this.getSize());
      for (int i = 0; i < rolls.length; i++) {
        rolls[i] = get(i).rollPerception();
        println(get(i).getName() + " rolled " + rolls[i]);
        for (int j = 0; j < chosenPhrases.size(); j++) {
          if (chosenPhrases.get(j).getDC() < rolls[i]) {
            // It's detected!
            traitScore[chosenPhrases.get(j).getTrait()] += get(i).getPersonality(chosenPhrases.get(j).getTrait());
          }
        }
      }
      // traitScore now stores all of our stores. Let's find the highest and find which room that is.
      int highest = traitScore[0];
      int bestTrait = 0;
      for (int i = 0; i < traitScore.length; i++) {
        if (traitScore[i] >= highest) {
          highest = traitScore[i];
          bestTrait = i;
        }
      }
      // now find the room
      for (DungeonTile t : openSet) {
        if (bestTrait == AGGRESSION && t instanceof Monster || t instanceof BigBad) {
          setDestinationTile(t);
        }
        else if (bestTrait == GREED && t instanceof Gear) {
          setDestinationTile(t);
        }
        else if (bestTrait == CURIOSITY && t instanceof Empty || t instanceof Trap) {
          setDestinationTile(t);
        }
      }

    }

    // Clear
    chosenPhrases = new ArrayList<Phrase>();
    currentPhrases = new ArrayList<Phrase>();
    openSet = new ArrayList<DungeonTile>();
    // Check north
    if (destinationTile != null) {
      if (! (destinationTile.row() - 1 < 0 || tile[destinationTile.row()-1][destinationTile.col()] instanceof Wall) ) {
        openSet.add(tile[destinationTile.row()-1][destinationTile.col()]);
      }

      if (!(destinationTile.row() + 1 == tile.length || tile[destinationTile.row()+1][destinationTile.col()] instanceof Wall)) {
        openSet.add(tile[destinationTile.row()+1][destinationTile.col()]);
      }

      if (!(destinationTile.col() - 1 < 0 || tile[destinationTile.row()][destinationTile.col()-1] instanceof Wall)) {
        openSet.add(tile[destinationTile.row()][destinationTile.col()-1]);
      }

      if (!(destinationTile.col() + 1 == tile[0].length || tile[destinationTile.row()][destinationTile.col()+1] instanceof Wall)) {
        openSet.add(tile[destinationTile.row()][destinationTile.col()+1]);
      }
    }

    // if more than one route is possible, generate possible phrases for each
    for (DungeonTile t : openSet) {
      currentPhrases.add(generatePhrase(t));
    }
    updatePhrases();
  }

  Phrase generatePhrase(DungeonTile t) {
    Phrase p;
    String direction = "... somewhere";

    if (t instanceof Monster || t instanceof BigBad) {
      int roll = (int) random(0, phrase[AGGRESSION].length);
      p = phrase[AGGRESSION][roll];
    }
    else if (t instanceof Gear) {
      int roll = (int) random(0, phrase[GREED].length);
      p = phrase[GREED][roll];
    }
    else if (t instanceof Trap) {
      int roll = (int) random(0, phrase[CURIOSITY].length);
      p = phrase[CURIOSITY][roll];
    }
    else {
      int roll = (int) random(0, phrase[MISC].length);
      p = phrase[MISC][roll];
    }

    // Find direction
    if (t.row() > destinationTile.row())
      direction = "south";
    if (t.row() < destinationTile.row())
      direction = "north";
    if (t.col() > destinationTile.col())
      direction = "east";
    if (t.col() < destinationTile.col())
      direction = "west";


    p.setDirection(direction);
    return p;
  }

  Phrase generateGeneric(DungeonTile t) {
    return null;
  }

  private boolean movingLeft(int col) {
    return x() > col * gridBoxSize() + gridBoxSize()/2 + xOffset();
  }
  private boolean movingRight(int col) {
    return x() < col * gridBoxSize() + gridBoxSize()/2 + xOffset();
  }
  private boolean movingDown(int row) {
    return y() < row * gridBoxSize() + gridBoxSize()/2 + yOffset();
  }
  private boolean movingUp(int row) {
    return y() > row * gridBoxSize() + gridBoxSize()/2 + yOffset();
  }

  private boolean inCenterOf(int row, int col) {
    return      x() == col * gridBoxSize() + gridBoxSize()/2 + xOffset()
            &&  y() == row * gridBoxSize() + gridBoxSize()/2 + yOffset();
  }

  int row() { return (int) (position.y / gridBoxSize()); }
  int col() { return (int) (position.x / gridBoxSize()); }
  float x() { return position.x + xOffset(); }
  float y() { return position.y + yOffset(); }

  int getSize() {
    return members.size();
  }

  PartyMember get(int i) {
    return members.get(i);
  }
  Party add(PartyMember m) {
    members.add(m);
    return this;
  }
}
