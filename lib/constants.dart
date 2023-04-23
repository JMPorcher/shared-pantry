import 'package:shared_pantry/models/item_category.dart';
import 'package:shared_pantry/providers/pantry_list_provider.dart';

import 'models/item.dart';
import 'models/pantry.dart';

Pantry kTestPantry = Pantry([kTestCategory], pantryTitle: 'Pantry 1');
Pantry kTestPantry2 = Pantry([kTestCategory2], pantryTitle: 'Pantry 2');

ItemCategory kTestCategory = ItemCategory(
  title: 'Test category',
  items: kTestList,
);

List<Item> kTestList = [
  Item('Test item 1', false),
  Item('Test item 2', false),
  Item('Test item 3', true),
];

ItemCategory kTestCategory2 = ItemCategory(
  title: 'Test category2',
  items: kTestList2
);

List<Item> kTestList2 = [
  Item('Test item 4', false),
  Item('Test item 5', false),
  Item('Test item 6', true),
];

