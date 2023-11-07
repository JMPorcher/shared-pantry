import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_pantry/widgets/add_button.dart';
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

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Expanded(
            child: pantryList.isEmpty
                ? const NoPantriesSplash()
                : ListView.builder(
                    itemCount: pantryList.length + 1,
                    itemBuilder: (_, index) {
                      if (index < pantryList.length) {
                        Pantry currentPantry = pantryList[index];
                        return GestureDetector(
                            onTap: () {
                              pantryProvider.switchPantry(index);
                              pageController.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.decelerate);
                              //TODO When developing the Card, add a tappable area to switch directly to pantry_screen instead of switching wherever the card is tapped. Also, consider making the cards extend or show an info bubble on tap to show details like no. of items and all users.
                            },
                            onLongPress: () {
                              pantryProvider.removePantryByIndex(index);
                            },
                            child: SpCard.pantry(currentPantry,
                                isSelected:
                                    index == pantryProvider.selectedPantryIndex));
                      } else {
                        return null;
                      }
                    })),
        SpButton(
          child: pantryList.isEmpty
              ? const Text('Start your first pantry',
                  style: TextStyle(color: Colors.white))
              : const Text('Add a pantry', style: TextStyle(color: Colors.white)),
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext context) => AddPantryDialog());
          },
        )
      ]),
    );
  }
}
