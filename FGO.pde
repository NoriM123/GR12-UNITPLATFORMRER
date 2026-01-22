class FGameObject extends FBox {

  final int L = -1;
  final int R = 1;

  FGameObject(float width, float height) {
    super(width, height);
  }


  void act() {
  }

  boolean isTouching(String n) {
    ArrayList<FContact> contacts = getContacts();
    for (int i = 0; i < contacts.size(); i++) {
      FContact fc = contacts.get(i);
      if (fc.contains(n)) {
        return true;
      }
    }
    return false;
  }


  boolean issTouching(FBox s, String n) {
    ArrayList<FContact> contactList = s.getContacts();
    for (FContact c : contactList) {
      if (n.equals("floor")) {
        if (c.contains("stonebricks") || c.contains("wall") ||c.contains("ice") || c.contains("bridge") || c.contains("treetopw")|| c.contains("treetopL") || c.contains("intersec") || c.contains("topg") || c.contains("springss")|| c.contains("grasstl")|| c.contains("grasstr")) {
          return true;
        }
      } else if (c.contains(n)) {
        return true;
      }
    }
    return false;
  }

  boolean isssTouching(FCircle c, String name) {
    ArrayList<FContact> contacts = c.getContacts();
    for (int i = 0; i < contacts.size(); i++) {
      if (contacts.get(i).contains(name)) return true;
    }
    return false;
  }
}
