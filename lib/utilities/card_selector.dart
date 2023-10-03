import 'package:flutter/material.dart';

import '../models/pantry.dart';

class CardSelector {
  CardSelector(this.pantries) {
      pantrySelectionStates = { for (Pantry pantry in pantries) pantry : false };
  }

  final List<Pantry> pantries;
  late Map<Pantry, bool> pantrySelectionStates;

  void selectPantry(Pantry pantry) {
    pantrySelectionStates.forEach((key, value) {value = false;});
    if (pantrySelectionStates.containsKey(pantry)) {
      pantrySelectionStates[pantry] = true;
    }
  }
}

//Supplies states to show one selected card