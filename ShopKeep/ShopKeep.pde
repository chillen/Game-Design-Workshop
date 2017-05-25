import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

/* Credits for shop theme: Department Store by Yahtzei [http://www.newgrounds.com/audio/listen/608682]
 * Available for non-commercial purposes!
 */
AudioPlayer player;
Minim minim;
final int INTRO = 0;
final int STOCKING = 1;
final int BATTLE = 2;
final int SELLING = 3;
final int GAMEOVER = 4;
PFont title;
PFont p;
PFont h1;
PFont l;
PImage keep;
PImage[] party;
int state = 0;
int money = 500;
int day = 1;
ArrayList<Item> allItems;
ArrayList<Adventure> adventures;
int bigBad;
final int CHANCE = 40; // out of 100 to be the big bad
Adventure currentAdventure;
ArrayList<String> actions;
final int MAX_ACTIONS = 5;
final int MAX_TAX = 30;
final int MIN_TAX = 5;
final int MAX_TAX_RICH = 300;
final int MIN_TAX_RICH = 50;
final int CHANCE_RICH = 10;

void setup() {
  actions = new ArrayList<String>();
  bigBad = (int) (random(1,4));
  title = createFont("slkscr.ttf", 64);
  allItems = populateItems();
  p = createFont("slkscr.ttf", 12);
  h1 = createFont("slkscr.ttf", 28);
  keep = loadImage("shopkeep.png");
  l = createFont("slkscr.ttf", 9);
  party = new PImage[3];
  for (int i = 0; i < party.length; i++) {
    int sprite = (int) random(1,100);
    party[i] = loadImage(""+sprite+".png");
  }
  adventures = populateAdventures();
  
  minim = new Minim(this);
  player = minim.loadFile("DepartmentStore.mp3", 2048);
  player.loop();
  size(800,600);
  background(180,150,130);
}

void draw() {
  switch(state) {
    case INTRO: 
      drawIntro();
      break;
    case STOCKING: 
      drawStocking();
      break;
    case BATTLE: 
      drawBattle();
      break;
    case SELLING: 
      drawSelling();
      break;
    case GAMEOVER: 
      drawGameOver();
      break;
    default:
      drawIntro();      
  }
}

ArrayList<Item> populateItems() {
  Table table = loadTable("items.csv", "header");
  ArrayList<Item> items = new ArrayList<Item>();
  int id = 1000;
  for (TableRow r : table.rows()) {
    String name = r.getString("Name");
    String description = r.getString("Description");
    int rarity = r.getInt("Rarity");
    int threat = r.getInt("Threat");
    int rand = (int) random(1,3);
    int stockPrice = (int) (pow(3, rand) + pow(10, rarity));
    int sellPrice = (int) (stockPrice + pow(3, rand+rarity));
    items.add(new Item(name, description, rarity, threat, stockPrice, sellPrice, id++));
  }
  
  return items;
}

ArrayList<Adventure> populateAdventures() {
  Table table = loadTable("adventures.csv", "header");
  ArrayList<Adventure> ad = new ArrayList<Adventure>();
  for (TableRow r : table.rows()) {
    String description = r.getString("Description");
    int threat = r.getInt("Threat");
    ad.add(new Adventure(description, threat));
  }
  
  return ad;
}

void drawIntro(){
  background(90, 60, 50);
  textFont(title);
  textAlign(CENTER, TOP);
  text("ShopKeep", width/2, height/2 - 140);
  
  textFont(p);
  textAlign(TOP, LEFT);
  text("Welcome to ShopKeep! Are you ready to take on the role of an NPC?\nIn ShopKeep, you are entering a world of spies, dragons, the living dead, and evil wizards! But enough of all that adventuring business. Real business is SHOP business.\nTake the role of a shopkeep and maximize profits. Every day, adventurers face new evils, but in the background lurks the ULTIMATE BIG BAD EVIL GUY... Well. That's the one that gives them the biggest headache. There are three types of evils: Barren, Wizard, and Crimelord. To defeat these evils, adventurers need specific gear. You get to provide them that gear! Guess what they'll need and you'll be rewarded. Also, sometimes adventurers are rich! Remember to watch what evils they talk about. The BBEG will be the most common evil and you can make sure to capitalize!", 
        10, height/2 - 40, width-10, height/2-40+200);
  
  textAlign(CENTER, CENTER);
  text(" < PRESS SPACEBAR TO BEGIN > ", width/2, height-100);
}

void keyPressed() {
  if (state == INTRO && key == ' ') {
    state = STOCKING;
  }
  else if (state == STOCKING && key == ' ') {
    int rand = (int) (random(0,100));
    int currAdventure = 1;
    if (rand <= CHANCE) {
      currAdventure = bigBad;
    }
    else {
      int r = (int) (random(0,100));
      if (bigBad == 1) 
        currAdventure = (r < 50)? 2 : 3;
      if (bigBad == 2) 
        currAdventure = (r < 50)? 1 : 3;
      if (bigBad == 3) 
        currAdventure = (r < 50)? 2 : 1;
    }
    
    int numPerThreat = adventures.size() / 3;
    rand = (int) (random((currAdventure-1)*numPerThreat, numPerThreat*currAdventure));
    currentAdventure = adventures.get(rand);
    state = BATTLE;
  }
  else if (state == BATTLE && key == ' ') {
    takeAction();
  }
  else if (state == BATTLE && key == 's') {
    state = STOCKING;
    actions = new ArrayList<String>();
    for (int i = 0; i < party.length; i++) {
      int sprite = (int) random(1,100);
      party[i] = loadImage(""+sprite+".png");
    }
  }
}

// They will attempt to buy what they can and sell some things. Sometimes items, sometimes not
// They start by selling you useless junk, then one item of common rarity, then they buy the most expensive crap they can til they're broke
void takeAction() {
  boolean rich = currentAdventure.money > 300;
  if (actions.size() <= MAX_ACTIONS) {
    if (actions.size() == 0) {
      int junkCost = (int) random(MIN_TAX, MAX_TAX);
      if (rich)
        junkCost = (int) random(MIN_TAX_RICH, MAX_TAX_RICH);
      money = max(money-junkCost, 0);
      currentAdventure.money+=junkCost;
      actions.add("Great. " + junkCost + "g worth of unsellable garbage.");
    }
    else if (actions.size() == 1) {
      int itemIndex;
      if (rich)
        while (allItems.get((itemIndex = (int) (random(0, allItems.size())))).rarity != 2 || allItems.get(itemIndex).threat == currentAdventure.threat) {}
      else
        while (allItems.get((itemIndex = (int) (random(0, allItems.size())))).rarity > 1 || allItems.get(itemIndex).threat == currentAdventure.threat) {}
      if (allItems.get(itemIndex).stockPrice <= money) {
        money -= allItems.get(itemIndex).stockPrice;
        currentAdventure.money+= allItems.get(itemIndex).stockPrice++;
        allItems.get(itemIndex).quantity++;
        actions.add("They sold me a " + allItems.get(itemIndex).name + ". Maybe I'll get some use out of it.");
      }
      else {
        actions.add("I can't afford their " + allItems.get(itemIndex).name + ", I'm not made of money!");
      }      
    }
    else {
      // Find all items which the shop has.
      ArrayList<Item> shop = new ArrayList<Item>();
      for (Item i : allItems) {
        if (i.quantity > 0 && (i.threat == currentAdventure.threat || i.threat == 0)) {
          shop.add(i);
        }
      }
      
      Item toSell = null;
      if (shop.size() == 0) {
        actions.add("I'm all out of stock!");
      }
      else {
        for (Item i : shop) {
          if (toSell == null && i.sellPrice <= currentAdventure.money) {
            toSell = i;
          }
          else {
            if (toSell != null && i.sellPrice <= currentAdventure.money && i.sellPrice > toSell.sellPrice) {
              toSell = i;
            }
          }
        }
      }
      
      if (toSell == null)
        actions.add("They couldn't buy anything!");
      else {
        actions.add("They purchased my " + toSell.name + ". That's a cool " + toSell.sellPrice + "g for me!");
        currentAdventure.money-= toSell.sellPrice;
        money += toSell.sellPrice;
        toSell.quantity--;
      }
    }
  }
  if (actions.size() >= MAX_ACTIONS) {
    actions.add("< Press s to start stocking for tomorrow >");
  }
}

void mouseClicked() {
  if (state == STOCKING) {
    int item = floor((180-mouseY)/10);
    if (item <= 0) {
      item *= -1;
      if (allItems.get(item).stockPrice <= money) {
        allItems.get(item).quantity++;
        money -= allItems.get(item).stockPrice;
      }
    }
  }
}

void drawStocking(){
  background(90, 60, 50);
  drawTopBar();
  
  textFont(h1);
  fill(240);
  text("Purchase your wares for tomorrow!", width/2, 120);
  
  textFont(p);
  text("< PRESS SPACEBAR TO START THE DAY >", width/2, 140);
  pushMatrix();
    translate(10, 160);
    fill(180, 160, 140);
    rect(0, 0, width-20, height-170);
    
    int item = floor((180-mouseY)/10);
    if (item <= 0) {
      item *= -1;
      noStroke();
      fill(40,25,20);
      rect(0, 16+(item)*10, width-20, 10);
    }
    
    textFont(l);
    textAlign(LEFT, CENTER);
    fill(240);
    pushMatrix();
      translate(5,10);
      text("NAME", 0, 0);
      text("DESCRIPTION", 200, 0);
      text("THREAT", 610, 0);
      text("COST", 670, 0);
      text("PRICE", 700, 0);
      text("STOCK", 730, 0);
      textFont(l);
      for (int i = 0; i < allItems.size(); i++) {
        pushMatrix();
          translate(0, 10*(i+1));
          text(allItems.get(i).name, 0, 0);
          text(allItems.get(i).description, 200, 0);
          text(getThreat(allItems.get(i).threat), 610, 0);
          text(allItems.get(i).stockPrice, 670, 0);
          text(allItems.get(i).sellPrice, 700, 0);
          text(allItems.get(i).quantity, 730, 0);
        popMatrix();
      }
    popMatrix();
  popMatrix();
  
  
  
}

String getThreat(int i) {
  String[] t = { "None", "Barron", "Wizard", "Crimelord" };
  return t[i];
}

void drawTopBar(){  // top bar
  pushMatrix();
    fill(70, 40, 30);
    translate(0,0);
    rect(0,0,width,100);
    
    pushMatrix();
      fill(240);
      textFont(p);
      textAlign(CENTER, CENTER);
      text("== LIL' DRAGON TAVERN AND ARMORY ==", width/2, 10);
      textFont(p);
      text("MONEY: " + money, width/2,50);
      text("DAY: " + day, width/2, 70);
    popMatrix();
  popMatrix();
}

void drawSelling(){}

void drawGameOver(){}

void drawBattle() {
  background(180, 160, 140);
  // Left character
  pushMatrix();
    translate(width/6,height/2-keep.height);
    textFont(h1);
    fill(240);
    text("YOU", keep.width/2, -60);
    fill(170, 140, 130);
    rect(0,0,keep.width, keep.height);
    image(keep, 0,0);
  popMatrix();
  
  // right characters
  
  pushMatrix();
    translate(width-width/3,height/2-keep.height);
    textFont(h1);
    fill(240);
    text("OPPONENTS", keep.width/2, -60);
    fill(170, 140, 130);
    pushMatrix();
      translate(-party[0].width, 0);
      for (int i = 0; i < party.length; i++) {  
        int x = i * party[i].width;
        rect(x,0,x+party[i].width, party[i].height);
        image(party[i], x,0);
      }
    popMatrix();
  textFont(p);
  popMatrix();
  
  // bottom bar
  pushMatrix();
    fill(70, 40, 30);
    translate(0, height/2);
    rect(0, 0 , width, height/2);
    textFont(p);
    textAlign(TOP, LEFT);
    fill(200, 160, 160);
    text("Mentioned Threat: " + getThreat(currentAdventure.threat), width/2+20, 20);
    fill(200, 200, 160);
    text("Available Funds: " + currentAdventure.money, width/2+20, 40);
    fill(240);
    text(currentAdventure.description, width/2+20, 50, width/2-40, 300);
    
    // actions
    textFont(p);
    String catted = String.join("\n", actions);
    fill(200, 200, 160);
    text("Merchant's Log: ", 10, 20);
    fill(240);
    text(catted, 10, 40, width/2-20, 400);
    
  popMatrix();
  
  strokeWeight(10);
  stroke(35, 20, 15);
  line(width/2, 0, width/2, height);
  strokeWeight(1);
  drawTopBar();
  
  

}