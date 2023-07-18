import 'package:shared_pantry/models/item_category.dart';

import 'models/item.dart';
import 'models/pantry.dart';

Pantry kTestPantry = Pantry([kTestCategory], pantryTitle: 'Persönlich');
Pantry kTestPantry2 = Pantry([kTestCategory2], pantryTitle: 'WG');

ItemCategory kTestCategory = ItemCategory(
  'Kühlschrank',
  items: kTestList,
);

List<Item> kTestList = [
  Item('Hafermilch', false),
  Item('Margarine', false),
  Item('Tofu', true),
];

ItemCategory kTestCategory2 = ItemCategory(
  'Putzmittel',
  items: kTestList2
);

List<Item> kTestList2 = [
  Item('Kloreiniger', false),
  Item('Schwämme', false),
  Item('Küchenrolle', true),
];

