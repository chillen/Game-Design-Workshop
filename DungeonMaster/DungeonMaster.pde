import controlP5.*;

DungeonTile[][] tile;
ControlP5 cp5;
GridView gridView;
DungeonTileFactory tileFactory = new DungeonTileFactory();
Party party;
Group partyPanel;
Group phrasePanel;
boolean exists = false;

// CONSTANTS
final float GRID_MOD = 0.3;
final float MOVE_SPEED = 5; // seconds per tile
final byte AGGRESSION = 0;
final byte GREED = 1;
final byte CURIOSITY = 2;
final byte MISC = 3;

String[][] map = {{"W","W","W","W","W","W","W","W","W"},
  {"W","E","E","T","E","G2","E","W","W"},
  {"W","M2","W","E","W","W","E","W","W"},
  {"S","E","W","M1","W","W","M4","W","W"},
  {"W","E","W","E","E","E","E","B","W"},
  {"W","E","E","M6","W","E","W","W","W"},
  {"W","W","E","G1","E","T","W","W","W"},
  {"W","W","E","W","M2","W","W","W","W"},
  {"W","W","E","T","E","W","W","W","W"},
  {"W","W","W","W","W","W","W","W","W"}}
  ;

Phrase[][] phrase = {
  {new Phrase(AGGRESSION, 10, "you see the door shaking and rattling horribly and hear the wails of a mysterious creature.")},
  {new Phrase(GREED, 10, "you notice the door is well protected. What treasures lie beyond?")},
  {new Phrase(CURIOSITY, 10, "you feel a strange, mysterious coldness. What could that be?")},
  {new Phrase(CURIOSITY, 0, "you notice that the door doesn't quite look like the others you've seen."), new Phrase(AGGRESSION, 0, "the door seems to have some scratchings on it.")}
};

ArrayList<Phrase> currentPhrases = new ArrayList<Phrase>();
ArrayList<Phrase> chosenPhrases = new ArrayList<Phrase>();

void setup() {
  size(800,600);
  generateMap();
  generateParty();
  initializeGUI();
}

void draw() {
  background(50,20,20);
  drawGrid();
  drawParty();
  party.move();
}

void initializeGUI() {
  gridView = new GridView();
  cp5 = new ControlP5(this);
  partyPanel = cp5.addGroup("party")
                  .setPosition(0, map.length*gridBoxSize()+15)
                  .setBackgroundHeight(height-map.length*gridBoxSize())
                  .setBackgroundColor(color(90))
                  .setWidth(width)
                  .disableCollapse()
                  ;
  phrasePanel = cp5.addGroup("phrases")
                  .setPosition(map[0].length*gridBoxSize()+22, 13)
                  .setBackgroundHeight(map.length*gridBoxSize() - 10)
                  .setBackgroundColor(color(90))
                  .setWidth(width - map[0].length*gridBoxSize() - 22)
                  .disableCollapse()
                  ;
  populatePartyPanel();
  updatePhrases();
}


void updatePhrases() {
  if (cp5 == null)
    return;
  if (exists)
    cp5.remove("checkBox");
  exists = true;
  CheckBox checkbox = cp5.addCheckBox("checkBox")
                .setPosition(10, 10)
                .setColorForeground(color(120))
                .setColorActive(color(255))
                .setColorLabel(color(255))
                .setSize(20, 20)
                .setItemsPerRow(1)
                .setSpacingColumn(30)
                .setSpacingRow(20)
                .setGroup(phrasePanel)
                ;
  for (int i = 0; i < currentPhrases.size(); i++) {
    checkbox.addItem(i+currentPhrases.get(i).toString(), i)
            .setLabel(currentPhrases.get(i).toString());
  }

}

void populatePartyPanel() {
  for (int i = 0; i < party.getSize(); i++) {
    PartyMember m = party.get(i);
    cp5.addTextlabel("member-"+i+"-name")
       .setText("Name: " + m.getName())
       .setPosition(i*width/party.getSize(), 5)
       .setGroup(partyPanel)
       ;

    cp5.addTextlabel("member-"+i+"-description")
       .setText(m.getDescription())
       .setPosition(5+i*width/party.getSize(), 20)
       .setWidth(width/party.getSize()-5)
       .setHeight(20)
       .setMultiline(true)
       .setGroup(partyPanel)
       ;
    cp5.addTextlabel("member-"+i+"-perception")
       .setText("PERC:  " + m.getPerception())
       .setPosition(i*width/party.getSize(), 45)
       .setGroup(partyPanel)
       ;
    cp5.addTextlabel("member-"+i+"-initiative")
      .setText("INIT:      " + m.getInitiative())
      .setPosition(i*width/party.getSize(), 60)
      .setGroup(partyPanel)
      ;
    cp5.addTextlabel("member-"+i+"-combat")
      .setText("COMB: " + m.getCombat())
      .setPosition(i*width/party.getSize(), 75)
      .setGroup(partyPanel)
      ;

  }
}

float xOffset() {
  int offset = (gridBoxSize() * map[0].length - gridBoxSize() * map.length) / 2;
  if (offset < 0)
    return -offset;
  return 0;
}

float yOffset() {
  int offset = (gridBoxSize() * map[0].length - gridBoxSize() * map.length) / 2;
  if (offset > 0)
    return offset;
  return 0;
}

void drawParty() {
  pushMatrix();
    fill(100,130,200);
    noStroke();
    ellipse(party.x(), party.y(), gridBoxSize()/2, gridBoxSize()/2);
  popMatrix();
}

void generateParty() {
  party = new Party();
  PartyMember m = new PartyMember();
  m.setLife("Darthur", "Barbarian; Eager, arrogant, and always looking for a fight.")
   .setPersonality(3, 0, -1) // Aggression, greed, curious
   .setStats(-1, 3, 2) //perception, combat, initiative
   ;
  party.add(m);

  m = new PartyMember();
  m.setLife("Cailyn", "Wizard; Wise and powerful wizard. Loves to learn. Trap? Take a peak anyway.")
   .setPersonality(-1, 0, 3)
   .setStats(2, 3, 0)
   ;
  party.add(m);

  m = new PartyMember();
  m.setLife("Kyra", "Rogue; Lives by the motto, 'Make coin, not war'.")
   .setPersonality(-2, 4, 1)
   .setStats(3, 0, 1)
   ;
  party.add(m);

  m = new PartyMember();
  m.setLife("Allara", "Cleric; Only wants to help. No real cares.")
   .setPersonality(-1, -1, 1)
   .setStats(1, 0, 2)
   ;
  party.add(m);

  party.start(3,0);
}

void generateMap() {
  tile = new DungeonTile[map.length][map[0].length];
  for (int r = 0; r < map.length; r++) {
    for (int c = 0; c < map[r].length; c++) {
       tile[r][c] = tileFactory.get(map[r][c], r, c);
    }
  }
}

void checkBox(float[] a) {
  chosenPhrases = new ArrayList<Phrase>();
  for (int i = 0; i < a.length; i++) {
    if (a[i] == 1.0) {
      chosenPhrases.add(currentPhrases.get(i));
    }
  }
}

void drawGrid() {
  // Height - Width / 2. If it's negative, we must offset the height and width is fine
  int boxSize = gridBoxSize();
  int numRows = map.length;
  int numCols = map[0].length;
  // draw background box
  fill(0);
  rect(0,0,max(numCols, numRows)*boxSize, max(numCols, numRows)*boxSize);

  stroke(255);

  pushMatrix();
  translate(xOffset(), yOffset());

  // Draw map background base color
  fill(100,70,100);
  rect(0,0,numCols*boxSize, numRows*boxSize);
  for (int r = 0; r < numRows; r++) {
    for (int c = 0; c < numCols; c++) {
       pushMatrix();
         translate(c*boxSize, r*boxSize);
         fill(tile[r][c].getTileColor());
         textAlign(CENTER, CENTER);
         rect(0,0,boxSize,boxSize);
         fill(255);
         text(tile[r][c].getTileText(), boxSize/2, boxSize/2);
       popMatrix();
       line(c*boxSize, 0, c*boxSize, numRows*boxSize);
    }
    line(0, r*boxSize, numCols*boxSize, r*boxSize);
  }
  popMatrix();
}

int gridBoxSize() {
  int numRows = map.length;
  int numCols = map[0].length;
  return floor(min((height - height*GRID_MOD)/numRows, (width - width*GRID_MOD)/numCols));
}
