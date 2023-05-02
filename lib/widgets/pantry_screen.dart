import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_pantry/dialogs/add_pantry_dialog.dart';
import 'package:shared_pantry/widgets/category_listview_scaffold.dart';
import 'package:loop_page_view/loop_page_view.dart';

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
    LoopPageController pageController =
        context.watch<PantryProvider>().pageController;
    List<Pantry> pantryList = context.watch<PantryProvider>().pantriesList;

    return pantryList.isNotEmpty
        ? LoopPageView.builder(
            controller: pageController,
            itemCount: pantryList.length,
            itemBuilder: (context, pantryIndex) {
              Pantry currentPantry = pantryList[pantryIndex];

              return SingleChildScrollView(
                  child: CategoryListViewColumn(
                      currentCategoryList: currentPantry.categoryList,
                      currentTitle: currentPantry.pantryTitle,
                      currentPantry: currentPantry));
            })
        : Scaffold(
            body: SafeArea(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) => const AddPantryDialog());
                },
                child: const Center(child: Text('Add your first pantry')),
              ),
            ),
          );
  }
}
