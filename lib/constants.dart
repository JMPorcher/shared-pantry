
import 'package:shared_pantry/models/item_category.dart';
import 'package:shared_pantry/providers/item_list_provider.dart';

import 'models/item.dart';

ItemCategory kTestCategory = ItemCategory(
  title: 'Test category',
  items: kTestList,
);
ItemCategory kTestCategory2 = ItemCategory(
  title: 'Test category 2',
  items: kTestList2,
);

List<Item> kTestList = [
  Item('Test item 1', false),
  Item('Test item 2', false),
  Item('Test item 3', true),
];

List<Item> kTestList2 = [
  Item('Test item 1', false),
  Item('Test item 2', false),
  Item('Test item 3', true),
];