import 'package:flutter/material.dart';
import 'package:shared_pantry/widgets/sp_cards.dart';

import '../models/pantry.dart';
import '../providers/pantry_provider.dart';

import '../widgets/list_bottom_gradient.dart';

class OverviewScreen extends StatelessWidget {
  const OverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    PantryProvider pantryProvider = PantryProvider();
    List<Pantry> pantryList = pantryProvider.pantriesList;
    int activePantry = pantryProvider.selectedPantryIndex;

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
                        activePantry = index;
                        print('index: $index - activePantry: $activePantry');
                      },
                      child: SpCard.pantry(currentPantry,
                              isSelected: index == activePantry)
                      ),
              );
            } else {
              return const Column(
                children: [
                  SizedBox(height: 50),
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
