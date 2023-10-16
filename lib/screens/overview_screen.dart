import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_pantry/widgets/sp_cards.dart';

import '../models/pantry.dart';
import '../providers/pantry_provider.dart';

import '../widgets/list_bottom_gradient.dart';

class OverviewScreen extends StatelessWidget {
  const OverviewScreen({super.key});

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
        const ListBottomGradient(),
      ],
    );
  }
}
