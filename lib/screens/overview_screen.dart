import 'package:flutter/material.dart';
import 'package:shared_pantry/widgets/sp_cards.dart';

import '../models/pantry.dart';
import '../providers/pantry_provider.dart';
import 'package:provider/provider.dart';

import '../utilities/card_selector.dart';
import '../widgets/list_bottom_gradient.dart';

class OverviewScreen extends StatelessWidget {
  const OverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Pantry> pantryList = context.watch<PantryProvider>().pantriesList;

    //Build a SingleItemSelected class. Give it a list of items. When an item is clicked, at first every item is de-selected,
    // then one is selected. Based on this, change the look of the UI list.
    CardSelector cardSelector = CardSelector(pantryList);

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        ListView.builder(
          itemCount: pantryList.isEmpty ? 1 : pantryList.length + 1,
          itemBuilder: (_, index) {
            if (index < pantryList.length) {
              Pantry currentPantry = pantryList[index];
              return SizedBox(
                height: 200,
                child: GestureDetector(
                  onTap: () {
                    context.read<PantryProvider>().switchPantry(index);
                    cardSelector.selectPantry(currentPantry);
                  },
                    child: SpCard.pantry(currentPantry, isSelected: cardSelector.pantrySelectionStates[index])),
              );
            } else {
              return Column(
                children: [
                  const SizedBox(height: 50),
                  SizedBox(
                    height: 100,
                    child: SpCard.text('Add a pantry'),
                  ),
                ],
              );
            }
          },
        ),
        const ListBottomGradient(),
      ],
    );
  }
}