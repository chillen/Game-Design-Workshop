float[] survivors = {
  100, 
  600, 
  1100
};
String[] conversations = {
 "I've been here for days. It's so cold... I- I think I'm freezing to death... My lantern ran out and I can't feel my legs... A little oil could help me escape.",
 "Please. I need food. I've been here for so long... I've done things I'm not proud of... I'm going to starve to death.",
 "I need oil... Please. I need to get out of here. I have some spare food. Please. I miss my family." 
};

String[] responses = {
 "Press <Y> to offer some lantern oil. Press <N> to walk away.",
 "Press <Y> to offer some food. Press <N> to walk away.",
 "Press <Y> to offer some lantern oil. Press <N> to walk away." 
};

final int BOX_SIZE = 30;
float lanternIntensity = 1;
final float LIGHT_MODIFIER = 55;
final float MAX_INTENSITY = 10;
final float MIN_INTENSITY = 0;
final float LANTERN_INCREMENT = 0.2;
final float SPEED = 1.1;
boolean moving = false;
final int BACKGROUND = 30;
float lanternOil = 100;
float hunger = 60;
float temperature = 100;
float heatThreshold = 30;
int tickCount = 0;
final int CALC_RATE = 100;
PShape oilIcon;
PShape foodIcon;
PShape tempIcon;
float breathTolerance;
boolean inDialogue = false;
int currentDialogue = -1;
boolean breathed = false;
float tickPosition = 0;
boolean tickGoingRight = true;
float tickSpeed = 7;

void setup() {
  size(800, 600); 
  populateSurvivors();
  oilIcon = loadShape("jerrycan.svg");
  foodIcon = loadShape("grapes.svg");
  tempIcon = loadShape("thermometer-cold.svg");
}

void draw() {
  background(BACKGROUND);

  calculate();

  if (moving) {
    moveRight();
  }

  // Player
  pushMatrix();
  translate(10, height-200-BOX_SIZE);

  // Lantern
  fill(10+lanternIntensity*LIGHT_MODIFIER);
  pushMatrix();
  translate(BOX_SIZE/2, BOX_SIZE/2);
  ellipse(0, 0, lanternIntensity*LIGHT_MODIFIER, lanternIntensity*LIGHT_MODIFIER);
  popMatrix();

  fill(BACKGROUND);
  noStroke();
  for (float i : survivors) {
    drawSurvivor(i);
  }

  fill(50);  
  rect(0, 0, BOX_SIZE, BOX_SIZE); 
  popMatrix();

  // Floor
  fill(0);
  rect(0, height-200, width, height);

  // Meters
  pushMatrix();
    translate(10, height-175);
    drawMeters();
  popMatrix();
  
  if (inDialogue) {
     textAlign(CENTER, CENTER);
     fill(200);
     textSize(16);
     text("Survivor: "  + conversations[currentDialogue], 0, 0, width-10, 200);
     fill(255);
     text(responses[currentDialogue], 0, 20, width-10, height);    
  }
}

void drawMeters() {

  pushMatrix();
  translate(5, 0);
  fill(100, 100, 0);
  rect(10, 0, 10, 100);
  fill(200, 200, 100);
  rect(10, 100-lanternOil, 10, lanternOil);
  shape(oilIcon, 0, 110, 32, 32);

  pushMatrix();
  translate(45, 0);
  fill(100, 0, 100);
  rect(10, 0, 10, 100);
  fill(200, 100, 200);
  rect(10, 100-hunger, 10, hunger);
  shape(foodIcon, 0, 110, 32, 32);

  pushMatrix();
  translate(45, 0);
  fill(100);
  rect(10, 0, 10, 100);
  fill(80, 150, 80);
  rect(10, 100-temperature, 10, temperature);
  fill(150, 80, 40);
  rect(10, 100-min(temperature, heatThreshold), 10, min(temperature, heatThreshold));
  shape(tempIcon, 0, 110, 32, 32);

  // Draw your breath meter
  pushMatrix();
  translate(60, 65);

  fill(150, 80, 40);
  rect(0, 0, 610, 10);

  fill(80, 150, 80);
  rect(610*breathTolerance/100/2, 0, 610*(1-breathTolerance/100), 10);   

  if (temperature > heatThreshold) {
    fill(100);
    rect(0, 0, 610, 10);
  }
  else {
   // Draw the breathing line
   if (breathed) {
     fill(0,200,0);
   } 
   else {
      fill(200,0,0); 
   }
   
   pushMatrix();
     translate(tickPosition, -5);
     noStroke();
     rect(0,0,2,20);
   popMatrix();
  }
  popMatrix();

  popMatrix();

  popMatrix();

  popMatrix();
}

void calculate() {

  if (tickCount % CALC_RATE == 0) {
    int roll = Math.round(100*random(0, 1));
    // Calculate Hunger
    if (hunger > 0 && roll > 85)
      hunger = max(0, hunger - 2);    
    // Calculate Temperature
    if (lanternIntensity < 2.0 && temperature > 0)
       temperature-= 1.3*2-lanternIntensity;
    if (lanternIntensity > 3.0 && temperature < 100)
       temperature += 0.3*lanternIntensity;   
    }
    // Calculate Oil
    if (lanternOil > 0) {
      lanternOil -= 0.01*lanternIntensity;
      if (lanternOil < 0) 
        lanternOil = 0;
    }
    
    if (temperature < heatThreshold) {
      if (tickGoingRight) {
        tickPosition+=tickSpeed;
        if (tickPosition > 610) {
         tickGoingRight = false; 
         if (!breathed)
           hunger-=5;
         else
           breathed = false;
        }
      }
      else {
       tickPosition-=tickSpeed;
        if (tickPosition < 1) {        
           tickGoingRight = true;
           if (!breathed)
             hunger = max(0, hunger - 5);
           else
             breathed = false;
        } 
      }
    }
    // Calculate Breath Tolerance. Bigger numbers are more difficult on the player
    breathTolerance = min(90, heatThreshold/4+(100-hunger)/1.1);
  

  tickCount++;
}

void drawSurvivor(float i) {
  rectMode(CORNER);
  pushMatrix();
  translate(i, 0);
  rect(0, 0, BOX_SIZE, BOX_SIZE); 
  popMatrix();
}

void populateSurvivors() {
}

void moveRight() {
  if (!inDialogue) {
    for (int i = 0; i < survivors.length; i++) {
      survivors[i] -= SPEED;
      // A survivor has collided
      if (survivors[i] < 10 && i > currentDialogue) {
       inDialogue = true; 
       currentDialogue = i;
      }
    }
  }
}

void startMovingRight() {
  moving = true;
}

void stopMovingRight() {
  moving = false;
}

void keyReleased() {
  if (key == CODED)
    if (keyCode == RIGHT)
      stopMovingRight();
  if (key == 'D' || key == 'd') {
    stopMovingRight();
  }
}

void keyPressed() {
  if (key == CODED)
    if (keyCode == RIGHT)
      startMovingRight();
  if (key == 'D' || key == 'd') {
    startMovingRight();
  } 
  if (key == '.') {
    lanternIntensity += (lanternIntensity<MAX_INTENSITY)? LANTERN_INCREMENT : 0;
  }
  if (key == ',') {
    lanternIntensity -= (lanternIntensity>MIN_INTENSITY)? LANTERN_INCREMENT : 0;
  }
  
  if (key == ' ') {
    if (temperature < heatThreshold) {
      // in the red
      if (breathed || tickPosition > 305 + breathTolerance/2 || tickPosition < 305 - breathTolerance/2) {
         hunger = max(0, hunger - 5);
      }
      else {
         breathed = true; 
      }
      
    } 
  }
  
  if (inDialogue && (key == 'y' || key == 'Y')) {
    println(currentDialogue);
    switch (currentDialogue) {
      case 0: 
        if (lanternOil > 20) {
          lanternOil -= 20;
        }
        else {
         lanternOil = 0; 
        }
        
        heatThreshold -= 10;
        break;
      case 1: 
        if (hunger > 20) {
          hunger -= 20; 
        }
        else {
         hunger = 0; 
        }
        
        heatThreshold -= 10;
        break;
     case 2: 
        if (lanternOil > 20) {
          lanternOil -= 20; 
        }
        else {
         lanternOil = 0; 
        }
        
        hunger = min(hunger + 10, 100);
        
        heatThreshold -= 10;
        break;
    }
    inDialogue = false;
  }
  
  if (inDialogue && (key == 'n' || key == 'N')) {
    heatThreshold += min(10, heatThreshold);
    inDialogue = false;
  }
  
}

