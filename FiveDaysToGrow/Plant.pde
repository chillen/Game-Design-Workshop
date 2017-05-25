class Plant {
  
  protected String soil, sun, water;
  final int SCALE = 10;
  // Generate a random plant
 Plant() {

 }

 Plant(String soil, String sun, String water) {
   this.soil = soil;
   this.sun = sun;
   this.water = water;
 }
 
 public void changeTrait(String t) {
   String[] soilTraits = {
     "mud", "dark", "fertilizer", "nitro"
   };
   String[] sunTraits = {
     "lots", "little"
   };
   String[] waterTraits = {
     "none", "some", "hydro"
   };
   
   for (int i = 0; i < sunTraits.length; i++) {
     if (sunTraits[i] == t)
       sun = t;
   }
   for (int i = 0; i < soilTraits.length; i++) {
     if (soilTraits[i] == t)
       soil = t;
   }
   for (int i = 0; i < waterTraits.length; i++) {
     if (waterTraits[i] == t)
       water = t;
   }
 }
 
 public boolean hasGrowthTrait(String t) {
   return t == soil || t == sun || t == water; 
 }
 
 public PShape getSprite() {
   PShape s;
   int w,h;
   w = h = this.getIntSize();  
   color pColor = this.getColor();
   fill(pColor);
   if (this.getIntShape() == ELLIPSE)
     s = createShape(this.getIntShape(), 0, 0, w, h);
   else
     s = createShape(this.getIntShape(), -w/2, -h/2, w, h);

   return s; 
 }
 
 public String getGrowthProperties() {
  return "Soil: " + soil + "; Sun: " + sun + "; Water: " + water; 
 }
 
 private int getIntSize() {
  return getIntSize(this.soil); 
 }
 
 private int getIntSize(String s) {
   if (s == "mud") return 5*SCALE;
   if (s == "dark") return 10*SCALE;
   if (s == "fertilizer") return 15*SCALE;
   if (s == "nitro") return 20*SCALE;
  
  return 0; 
 }
 
 private int getIntShape() {
   if (sun == "little") return RECT;
   if (sun == "lots") return ELLIPSE;
   return RECT;
 }
 
 public String getSize() {
   if (soil == "mud") return "tiny";
   if (soil == "dark") return "small";
   if (soil == "fertilizer") return "medium";
   if (soil == "nitro") return "large";
   
   return "tiny";
 }
 
 public String getShape() {
   if (sun == "little") return "square";
   if (sun == "lots") return "circle";
   
   return "square";
 }
 
 public String getFlavour() {
   if (water == "none") return "tangy";
   if (water == "some") return "spicy";
   if (water == "hydro") return "sweet";
   return "tangy";
 }
 
 private color getColor() { 
   if (this.getFlavour().equals("tangy")) return color(180,180,0);
   if (this.getFlavour().equals("spicy")) return color(200,0,0);
   if (this.getFlavour().equals("sweet")) return color(50,200,25);
   
   return color(255);
 }
 
 public String toString() {
   return "A " + getSize() + " plant, shaped like a " + getShape() + " and tastes " + getFlavour(); 
 }
 
}