import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_pantry/models/item_category.dart';
import 'package:shared_pantry/providers/pantry_provider.dart';
import 'package:shared_pantry/widgets/no_categories_splash.dart';
import 'package:shared_pantry/widgets/sp_cards.dart';

import '../dialogs/add_category_dialog.dart';
import '../models/pantry.dart';
import '../widgets/add_button.dart';
import '../widgets/category_expansion_tile.dart';

class PantryScreen extends StatelessWidget {
  const PantryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PantryProvider pantryProvider = context.watch<PantryProvider>();
    final int currentPantryIndex = pantryProvider.selectedPantryIndex;
    final Pantry currentPantry =
        pantryProvider.pantriesList[currentPantryIndex];
    final List<ItemCategory> currentCategoryList = currentPantry.categories;

    return Column(
      children: [
        SpCard.pantry(
          currentPantry,
          isSelected: false,
          isInOverviewScreen: false,
          onTap: () {},
          cardText: currentPantry.title,
        ),
        //TODO Replace card with whole width widget, possibly SliverAppBar
        currentCategoryList.isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                    const NoCategoriesSplashScreen(),
                    SpButton(
                        child: const Text('Add your first category',
                            style: TextStyle(color: Colors.white)),
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  AddCategoryDialog(currentCategoryList));
                        })
                  ])
            : ListView.builder(
                shrinkWrap: true,
                itemCount: currentCategoryList.length + 1,
                itemBuilder: (context, index) {
                  if (index < currentCategoryList.length) {
                    ItemCategory currentCategory = currentCategoryList[index];
                    return CategoryExpansionTile(currentCategory,
                        itemCategoryList: currentCategoryList);
                  } else {
                    return SpButton(
                        child: const Text('Add a category',
                            style: TextStyle(color: Colors.white)),
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  AddCategoryDialog(currentCategoryList));
                        });
                  }
                })
      ],
    );
  }
}
