import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_pantry/widgets/sp_cards.dart';

import '../models/pantry.dart';
import '../providers/pantry_provider.dart';

class OverviewScreen extends StatelessWidget {
  final PageController pageController;

  const OverviewScreen(this.pageController, {super.key});

  @override
  Widget build(BuildContext context) {
    PantryProvider pantryProvider = Provider.of<PantryProvider>(context);
    List<Pantry> pantryList = pantryProvider.pantriesList;

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        ListView.builder(
          itemCount: pantryList.isEmpty ? 1 : pantryList.length + 1,
          itemBuilder: (_, index) {
            if (index < pantryList.length) {
              Pantry currentPantry = pantryList[index];
              return GestureDetector(
                  onTap: () {
                    pantryProvider.switchPantry(index);
                    pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.linear);
                    //TODO When developing the Card, add a tappable area to switch directly to pantry_screen instead of switching wherever the card is tapped.
                  },
                  child: SpCard.pantry(currentPantry,
                          isSelected: index == pantryProvider.selectedPantryIndex)
                  );
            } else {
              return const Column(
                children: [
                  SizedBox(height: 50),
                  SpCard.text('Add a pantry'),
                ],
              );
            }
          },
        ),
      ],
    );
  }
}
