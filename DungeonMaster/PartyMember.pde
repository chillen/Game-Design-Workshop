class PartyMember {
  String name;
  String description;

  // Personality
  int aggression;
  int greed;
  int curiosity;

  // DC's
  int perception;
  int combat;
  int initiative;

  PartyMember() {
    setLife("ERR", "I AM ERROR").setPersonality(0,0,0).setStats(0,0,0);
  }

  int rollPerception() {
    int roll = (int) random(1, 20);
    return roll + perception;
  }

  PartyMember setLife(String n, String d) { setName(n); setDescription(d); return this; }
  String getName() { return name; }
  PartyMember setName(String n) { name = n; return this; }
  String getDescription() { return description; }
  PartyMember setDescription(String d) { description = d; return this; }

  PartyMember setPersonality(int a, int g, int c) { setAggression(a); setGreed(g); setCuriosity(c); return this; }
  int getAggression() { return aggression; }
  PartyMember setAggression(int a) { aggression = a; return this; }
  int getGreed() { return greed; }
  PartyMember setGreed(int g) { greed = g; return this; }
  int getCuriosity() { return curiosity; }
  PartyMember setCuriosity(int c) { curiosity = c; return this; }
  int getPersonality(byte b) {
    switch(b) {
      case 0: return getAggression();
      case 1: return getGreed();
      case 2: return getCuriosity();
      default: return -1;
    }
  }


  PartyMember setStats(int p, int c, int i) { setPerception(p); setCombat(c); setInitiative(i); return this; }
  int getPerception() { return perception; }
  PartyMember setPerception(int p) { perception = p; return this; }
  int getCombat() { return combat; }
  PartyMember setCombat(int c) { combat = c; return this; }
  int getInitiative() { return initiative; }
  PartyMember setInitiative(int i) { initiative = i; return this; }
}
