import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/pantry.dart';

class AppStateProvider extends ChangeNotifier {
  AppStateProvider(this.lastShownScreen, this.lastShownPantryId) {
    shownScreenIndex = lastShownScreen;
    mainScreenPageController = PageController(initialPage: shownScreenIndex);
    _selectedPantryId = lastShownPantryId;
  }

  final String lastShownPantryId;
  String _selectedPantryId = '';
  String get selectedPantryId => _selectedPantryId;
  set newSelectedPantryId(String newId){
    print('id received: $newId');
    _selectedPantryId = newId;
    print('new id: $_selectedPantryId');
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
