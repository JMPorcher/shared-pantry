import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_pantry/widgets/category_listview_scaffold.dart';

import '../models/pantry.dart';
import '../providers/pantry_list_provider.dart';

class PantryScreen extends StatefulWidget {
  const PantryScreen({Key? key}) : super(key: key);

  @override
  State<PantryScreen> createState() => _PantryScreenState();
}

class _PantryScreenState extends State<PantryScreen> {
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    List<Pantry> pantryList =
        context
            .watch<PantryProvider>()
            .pantriesList;

    return PageView.builder(
            itemCount: pantryList.length,
            itemBuilder: (context, pantryIndex) {
              Pantry currentPantry = pantryList[pantryIndex];

              return SingleChildScrollView(
                child: CategoryListViewColumn(
                  currentCategoryList: currentPantry.categoryList,
                  currentTitle: currentPantry.pantryTitle,
                  currentPantry: currentPantry,
                  pageController: pageController)
              );
            }
        );
  }
}
