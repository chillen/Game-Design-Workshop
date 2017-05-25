import controlP5.*;

Plant playerPlant;
Plant goal;
Plant[] enemyPlant;
ControlP5 cp5;
Button nextDay;
Textlabel myTraits, enemyTraits, currentDay, goalTraits, enemyGrowth, myGrowth, choose;
Group mySide, enemySide;
DropdownList dailyChange;
int today = 0;
final int NO_CHANGE = 9999;
String[] traits = {"lots", "little","mud", "dark", "fertilizer", "nitro", "none", "some", "hydro"};

void setup() {
  size(800, 600);
  playerPlant = new Plant("mud", "little", "none");
  goal = new Plant("dark", "little", "hydro");
  enemyPlant = new Plant[] {
    new Plant("fertilizer", "lots", "some"),
    new Plant("nitro", "little", "hydro"),
    new Plant("mud", "lots", "hydro"),
    new Plant("dark", "lots", "none"),
    new Plant("mud", "little", "some"),
    goal
  };
  
  cp5 = new ControlP5(this);
 
  goalTraits = cp5.addTextlabel("goaltraits")
                .setText("Goal: " + goal)
                .setPosition(10,10);

  mySide = cp5.addGroup("My plant stats")
                .setPosition(0,300)
                .setBackgroundHeight(300)
                .setWidth(399)
                .setBackgroundColor(color(255,50))
                .disableCollapse()
                ;
  enemySide = cp5.addGroup("Today's Plant ")
                .setPosition(401,300)
                .setBackgroundHeight(300)
                .setWidth(399)
                .setBackgroundColor(color(255,50))
                .disableCollapse()
                ;
                
  currentDay = cp5.addTextlabel("currentday")
                .setPosition(10,30);
                
  myTraits = cp5.addTextlabel("mytraits")
                .setPosition(0,10)
                .setGroup(mySide)
                ;
  myGrowth = cp5.addTextlabel("mygrowth")
                .setPosition(0,40)
                .setGroup(mySide)
                ;
                
  enemyTraits = cp5.addTextlabel("enemytraits")
                .setPosition(0,10)
                .setGroup(enemySide);
                
   enemyGrowth = cp5.addTextlabel("enemygrowth")
                .setPosition(0,40)
                .setGroup(enemySide)
                ;             
   nextDay = cp5.addButton("nextDay")
     .setCaptionLabel("Sleep Till Tomorrow")
     .setPosition(100,200)
     .setSize(150,19)
     .setGroup(mySide)
     ;
    
    dailyChange = cp5.addDropdownList("changeGrowthTrait")
                     .setPosition(100,100)
                     .setWidth(150)
                     .setGroup(mySide)
                     .setCaptionLabel("Change How You're Growing")
                     .close()
                     ;
    update();
}

void update() {       
  if (today < 5) {
    currentDay.setText("Day "+(today+1)+" of 5");          
    myTraits.setText("Current Traits: " + playerPlant);
    myGrowth.setText("Current Growth Method: " + playerPlant.getGrowthProperties());         
    enemyTraits.setText("Today's Traits: " + enemyPlant[today]);    
    enemyGrowth.setText("Current Growth Method: " + enemyPlant[today].getGrowthProperties());  
    populateChangesList(); 
  }
  else {
     currentDay.setText("Game Over!");    
     myTraits.setText("Final Traits: " + playerPlant);
     myGrowth.setText("Final Growth Method: " + playerPlant.getGrowthProperties());         
     enemyTraits.setText("Goal Traits: " + enemyPlant[today]);    
     enemyGrowth.setText("Goal Growth Method: " + enemyPlant[today].getGrowthProperties());  
     enemySide.setCaptionLabel("Goal Plant");
     populateChangesList(); 
     dailyChange.clear().setCaptionLabel("Thanks for Playing!").close();
  }
}

void populateChangesList() {
   dailyChange.clear()
               .setCaptionLabel("Change How You're Growing")
               .close();
   
  
   String[] sunTraits = {
     "lots", "little"
   };
   String[] soilTraits = {
     "mud", "dark", "fertilizer", "nitro"
   };
   String[] waterTraits = {
     "none", "some", "hydro"
   };
      
   dailyChange.addItem("Nothing", NO_CHANGE);

   for (int i = 0; i < sunTraits.length; i++) {
     if (!playerPlant.hasGrowthTrait(sunTraits[i]))
       dailyChange.addItem("Sun: " + sunTraits[i], i);
   }
   for (int i = 0; i < soilTraits.length; i++) {
     if (!playerPlant.hasGrowthTrait(soilTraits[i]))
       dailyChange.addItem("Soil: " + soilTraits[i], i+sunTraits.length);
   }
   for (int i = 0; i < waterTraits.length; i++) {
     if (!playerPlant.hasGrowthTrait(waterTraits[i]))
       dailyChange.addItem("Water: " + waterTraits[i], i+sunTraits.length+soilTraits.length);
   }
}

void nextDay() {
 today++;
 int value = (int) dailyChange.getItem((int)dailyChange.getValue()).get("value");
 if (value != NO_CHANGE)
   playerPlant.changeTrait(traits[value]);
 update();
}

void draw() {
  background(0);
  shape(playerPlant.getSprite(), 150, 150);
  shape(enemyPlant[today].getSprite(), 600, 150);
}