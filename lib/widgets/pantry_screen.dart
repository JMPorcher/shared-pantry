import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_pantry/widgets/category_listview_column.dart';

import '../dialogs/shopping_list_dialog.dart';
import '../models/pantry.dart';
import '../providers/pantry_list_provider.dart';

class PantryScreen extends StatefulWidget {
  const PantryScreen({Key? key}) : super(key: key);

  @override
  State<PantryScreen> createState() => _PantryScreenState();
}

class _PantryScreenState extends State<PantryScreen> {


  @override
  Widget build(BuildContext context) {
    List<Pantry> pantryList =
        context
            .watch<PantryProvider>()
            .pantriesList;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Shared Pantry'),
          actions: <Widget>[
            IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                      const ShoppingListDialog());
                }),
          ],
        ),
        body: PageView.builder(
            itemCount: pantryList.length,
            itemBuilder: (context, pantryIndex) {
              Pantry currentPantry = pantryList[pantryIndex];

              return SingleChildScrollView(
                child: CategoryListViewColumn(currentCategoryList: currentPantry.categoryList,)
              );
            }
        ));
  }
}
