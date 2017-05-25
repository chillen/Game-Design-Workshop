class Adventure {
  public String description;
  public int threat;
  public int money;
  
  Adventure(String d, int t) {
    money = (int) (random(100,300));
    if ( (int) random(1,100) <= CHANCE_RICH) {
      money = (int) (random(300,1500));
    }
    threat = t;
    description = d;
  }
  
}