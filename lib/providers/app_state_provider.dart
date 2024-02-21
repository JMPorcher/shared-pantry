import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppStateProvider extends ChangeNotifier {
  AppStateProvider(this.lastShownScreen, this.lastShownPantryId) {
    shownScreenIndex = lastShownScreen;
    _selectedPantryId = lastShownPantryId;
    mainScreenPageController = PageController(initialPage: shownScreenIndex);
  }

  final String lastShownPantryId;
  String _selectedPantryId = '';
  String get selectedPantryId => _selectedPantryId;
  set newSelectedPantryId(String newId){
    _selectedPantryId = newId;
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
