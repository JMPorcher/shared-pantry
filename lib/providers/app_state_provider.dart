import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppStateProvider extends ChangeNotifier {
  AppStateProvider(this.lastShownScreen, this.lastShownPantryIndex) {
    shownScreenIndex = lastShownScreen;
    _selectedPantryIndex = lastShownPantryIndex;
    mainScreenPageController = PageController(initialPage: shownScreenIndex);
  }

  final int lastShownPantryIndex;
  int _selectedPantryIndex = 0;
  int get selectedPantryIndex => _selectedPantryIndex;
  set newPantryIndex(int newIndex){
    _selectedPantryIndex = newIndex;
  }

  final int lastShownScreen;
  int shownScreenIndex = 0;

  late final PageController mainScreenPageController;

  void switchActiveScreen(newIndex) async {
    shownScreenIndex = newIndex;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt('Last shown screen', newIndex);
    notifyListeners();
  }
}
