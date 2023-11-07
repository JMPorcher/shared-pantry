import 'package:flutter/material.dart';
import 'package:shared_pantry/models/item_category.dart';

import 'models/item.dart';
import 'models/pantry.dart';

Pantry kTestPantry = Pantry(title: 'Persönlich', categories: [kTestCategory, kTestCategory4, kTestCategory5]);
Pantry kTestPantry2 = Pantry(title: 'WG', categories: [kTestCategory2]);
Pantry kTestPantry3 = Pantry(title: 'Werkzeug', categories: [kTestCategory3]);

ItemCategory kTestCategory = ItemCategory(
  'Kühlschrank',
  items: kTestList,
);

List<Item> kTestList = [
  Item('Hafermilch', isAvailable: false),
  Item('Margarine', isAvailable: false),
  Item('Tofu', isAvailable: true),
];

ItemCategory kTestCategory2 = ItemCategory(
  'Putzmittel',
  items: kTestList2
);

List<Item> kTestList2 = [
  Item('Kloreiniger', isAvailable: false),
  Item('Schwämme', isAvailable: false),
  Item('Küchenrolle', isAvailable: true),
];

ItemCategory kTestCategory3 = ItemCategory(
    'Eisenwaren',
    items: kTestList3
);

List<Item> kTestList3 = [
  Item('So viele Äxte, dass es langsam schwierig wird zu erklären', isAvailable: false),
  Item('Nägel', isAvailable: false),
  Item('Hammer', isAvailable: true),
];

ItemCategory kTestCategory4 = ItemCategory(
    'Kohlenhydrate',
    items: kTestList4
);

List<Item> kTestList4 = [
  Item('Nuddeln', isAvailable: false),
  Item('Reis', isAvailable: false),
  Item('Kartoffeln', isAvailable: true),
];

ItemCategory kTestCategory5 = ItemCategory(
    'Schreibwaren',
    items: kTestList5
);

List<Item> kTestList5 = [
  Item('Briefumschläge DIN lang', isAvailable: false),
  Item('Briefmarken 0,85', isAvailable: false),
  Item('Tackernadeln', isAvailable: true),
];


// Colors:
const Color kColor1 = Color(0xFFFAF9F7);
const Color kColor11 = Color(0xFFDDD8C4);
const Color kColor2 = Color(0xFFA3C9A8);
const Color kColor3 = Color(0xFF84B59F);
const Color kColor4 = Color(0xFF69A297);
const Color kColor5 = Color(0xFF50808E);
const Color kColor51 = Color(0xFF2D4850);
const Color kColor6 = Color(0xFF9E7682);
const Color kColor61 = Color(0xFFd8c8cd);

