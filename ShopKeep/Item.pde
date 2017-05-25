class Item {
  public int rarity, stockPrice, sellPrice, threat, id, quantity;
  public String description, name;
  
  Item (String n, String d, int r, int t, int stock, int sell, int id) {
    name = n;
    description = d;
    rarity = r;
    threat = t;
    stockPrice = stock;
    sellPrice = sell;
    this.id = id;
    quantity = 0;
  }
  
  
  
  boolean equals (Item i) {
    return i.id - id == 0;
  }
}