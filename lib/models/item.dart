class Item {
  Item(this.title, this.isAvailable);

  String title;
  bool isAvailable = false;

  void toggleAvailable() {
    isAvailable = !isAvailable;
  }


}