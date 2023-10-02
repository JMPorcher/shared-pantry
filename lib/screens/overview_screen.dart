import 'package:flutter/material.dart';
import 'package:shared_pantry/widgets/cards.dart';

import '../models/pantry.dart';
import '../providers/pantry_provider.dart';
import 'package:provider/provider.dart';

import '../widgets/list_bottom_gradient.dart';

class OverviewScreen extends StatelessWidget {
  const OverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Pantry> pantryList = context.watch<PantryProvider>().pantriesList;

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
                child: PantryCard.pantry(currentPantry),
              );
            } else {
              return const Column(
                children: [
                  SizedBox(height: 50),
                  SizedBox(
                    height: 100,
                    child: PantryCard.text('Add a pantry'),
                  ),
                ],
              );
            }
          },
        ),
        ListBottomGradient(),
      ],
    );
  }


}
