class Item {
  Item(this.title, {this.isAvailable = false});

  String title;
  bool isAvailable;

  void toggleAvailable() {
    isAvailable = !isAvailable;
  }

  void editTitle(String newTitle) {
    title = newTitle;
  }
  //TODO Implement editTitle feature, depends on layout
}