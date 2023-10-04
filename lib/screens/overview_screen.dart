import 'package:flutter/material.dart';
import 'package:shared_pantry/widgets/sp_cards.dart';

import '../models/pantry.dart';
import '../providers/pantry_provider.dart';
import 'package:provider/provider.dart';

import '../widgets/list_bottom_gradient.dart';

class OverviewScreen extends StatelessWidget {
  const OverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Pantry> pantryList = context.watch<PantryProvider>().pantriesList;
    ValueNotifier<Map<Pantry, bool>> pantrySelectionStatesNotifier =
        ValueNotifier<Map<Pantry, bool>>(
            {for (Pantry pantry in pantryList) pantry: false});

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
                        Map<Pantry, bool> newSelectionStates = {
                          for (Pantry pantry in pantryList) pantry: false
                        };
                        newSelectionStates[currentPantry] = true;
                        pantrySelectionStatesNotifier.value =
                            newSelectionStates;
                        pantrySelectionStatesNotifier.value.forEach((key, value) {print('onTap: $key, $value');});
                      },
                      child: ValueListenableBuilder<Map<Pantry, bool>>(
                        valueListenable: pantrySelectionStatesNotifier,
                        builder: (context, pantrySelectionStates, child) {
                          pantrySelectionStatesNotifier.value.forEach((key, value) {print('build: $key, $value');});
                          //pantrySelectionStates.forEach((key, value) {print('build: $key, $value}');});
                          return SpCard.pantry(currentPantry,
                              isSelected: pantrySelectionStatesNotifier.value[currentPantry], key: UniqueKey(),);
                        },
                      ),
                    )
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
