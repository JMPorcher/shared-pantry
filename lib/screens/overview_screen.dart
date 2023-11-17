import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_pantry/widgets/sp_button.dart';
import 'package:shared_pantry/widgets/no_pantries_splash.dart';
import 'package:shared_pantry/widgets/sp_cards.dart';

import '../dialogs/add_pantry_dialog.dart';
import '../models/pantry.dart';
import '../providers/pantry_provider.dart';

class OverviewScreen extends StatelessWidget {
  const OverviewScreen({super.key});


  @override
  Widget build(BuildContext context) {
    PantryProvider pantryProvider = Provider.of<PantryProvider>(context);
    final PageController pageController =
        pantryProvider.mainScreenPageController;
    List<Pantry> pantryList = pantryProvider.pantriesList;

    bool newActivatedPantryIsOldActivatedPantry = false;

    return Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Expanded(
          child: pantryList.isEmpty
              ? Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const NoPantriesSplash(),
                    SpButton(
                      child: const Text('Start your first pantry',
                          style: TextStyle(color: Colors.white)),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                AddPantryDialog());
                      },
                    )
                  ],
                )
              : ListView.builder(
                  itemCount: pantryList.length + 1,
                  itemBuilder: (_, index) {
                    if (index < pantryList.length) {
                      Pantry currentPantry = pantryList[index];
                      return GestureDetector(
                        onTap: () {
                          pantryProvider.switchPantry(index);
                        },
                        onLongPress: () {
                          pantryProvider.removePantryByIndex(index);
                        },
                        child: SpCard.pantry(
                            currentPantry,
                            isSelected:
                                index == pantryProvider.selectedPantryIndex,
                            isInOverviewScreen: true,
                            onTap: () {
                              newActivatedPantryIsOldActivatedPantry = index == pantryProvider.selectedPantryIndex;
                              pantryProvider.switchPantry(index);
                              Timer(Duration(milliseconds: newActivatedPantryIsOldActivatedPantry ? 0 : 300), () {
                                pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.decelerate);
                              });
                            },
                            cardText: currentPantry.title),
                      );
                    } else {
                      return SpButton(
                        child: const Text('Add a pantry',
                                style: TextStyle(color: Colors.white)),
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  AddPantryDialog());
                        },
                      );
                    }
                  })),
    ]);
  }
}
