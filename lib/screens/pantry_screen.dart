import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_pantry/constants.dart';
import 'package:shared_pantry/dialogs/edit_pantry_dialog.dart';
import 'package:shared_pantry/models/item_category.dart';
import 'package:shared_pantry/providers/app_state_provider.dart';
import 'package:shared_pantry/providers/pantry_provider.dart';
import 'package:shared_pantry/widgets/no_categories_splash.dart';
import 'package:shared_pantry/widgets/sp_card.dart';

import '../dialogs/add_category_dialog.dart';
import '../models/pantry.dart';
import '../widgets/buttons.dart';
import '../widgets/category_expansion_tile.dart';

class PantryScreen extends StatefulWidget {
  const PantryScreen({super.key});

  @override
  State<PantryScreen> createState() => _PantryScreenState();
}

class _PantryScreenState extends State<PantryScreen> {
  late final PantryProvider pantryProvider;
  late final AppStateProvider appStateProvider;
  late final int currentPantryIndex;
  late final Pantry currentPantry;
  late final List<ItemCategory> currentCategoryList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pantryProvider = context.watch<PantryProvider>();

    currentPantryIndex = appStateProvider.selectedPantryIndex;
    currentPantry = pantryProvider.pantriesList[currentPantryIndex];
    currentCategoryList = currentPantry.categories;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SpCard(
          currentPantry,
          isSelected: false,
          isInOverviewScreen: false,
          onTap: ()
            => showDialog(context: context, builder: (BuildContext context)
              => EditPantryDialog(pantry: currentPantry)),
          cardText: currentPantry.title,
        ),
        //TODO Surround card with SliverAppBar
        if (currentCategoryList.isEmpty) NoCategoriesSplashView(currentCategoryList: currentCategoryList)
        else buildCategories(currentCategoryList)
      ],
    );
  }

  Expanded buildCategories(List<ItemCategory> currentCategoryList) {
    return Expanded(
                  child: ListView.builder(
              shrinkWrap: true,
              itemCount: currentCategoryList.length + 1,
              itemBuilder: (context, index) {
                  if (index < currentCategoryList.length) {
                    ItemCategory currentCategory = currentCategoryList[index];
                    return CategoryExpansionTile(currentCategory,
                        itemCategoryList: currentCategoryList);
                  } else {
                    return AddCategoryButton(currentCategoryList);
                  }
              }),
                );
  }
}

class AddCategoryButton extends StatelessWidget {
  const AddCategoryButton(this.currentCategoryList, {
    super.key,
  });

  final List<ItemCategory> currentCategoryList;

  @override
  Widget build(BuildContext context) {
    return SpButton.filledButton(
        child: const Text('Add a category',
            style: kFilledButtonTextStyle),
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) =>
                  AddCategoryDialog(currentCategoryList));
        });
  }
}

class NoCategoriesSplashView extends StatelessWidget {
  const NoCategoriesSplashView({
    super.key,
    required this.currentCategoryList,
  });

  final List<ItemCategory> currentCategoryList;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                  const NoCategoriesSplashScreen(),
                  AddCategoryButton(currentCategoryList)
                ]),
    );
  }
}
