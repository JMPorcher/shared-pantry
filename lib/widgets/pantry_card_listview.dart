import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_pantry/providers/app_state_provider.dart';
import 'package:shared_pantry/widgets/buttons.dart';
import 'package:shared_pantry/widgets/sp_card.dart';

import '../constants.dart';
import '../dialogs/add_pantry_dialog.dart';
import '../models/pantry.dart';
import '../providers/pantry_provider.dart';

class PantryCardListView extends StatelessWidget {

  const PantryCardListView({
    super.key,
    required this.context,
    required this.appStateProvider
  });

  final BuildContext context;
  final AppStateProvider appStateProvider;

  @override
  Widget build(BuildContext context) {
    final PantryProvider pantryProvider = context.watch<PantryProvider>();
    final List<Pantry> pantryList = pantryProvider.pantriesList;
    final PageController pageController =
        appStateProvider.mainScreenPageController;
    return ListView.builder(
        itemCount: pantryList.length + 1,
        itemBuilder: (_, index) {
          if (index < pantryList.length) {
            Pantry currentPantry = pantryList[index];
            return PantryCard(pantryProvider: pantryProvider, currentPantry: currentPantry, index: index, appStateProvider: appStateProvider,);
          } else {
            return const AddPantryButton();
          }
        });
  }
}

class PantryCard extends StatelessWidget {
  const PantryCard({
    super.key,
    required this.pantryProvider,
    required this.appStateProvider,
    required this.currentPantry,
    required this.index
  });

  final PantryProvider pantryProvider;
  final AppStateProvider appStateProvider;
  final Pantry currentPantry;
  final int index;

  @override
  Widget build(BuildContext context) {
    final PageController pageController =
        appStateProvider.mainScreenPageController;
    return GestureDetector(
      onTap: () => pantryProvider.switchPantry(index),
      onLongPress: () => pantryProvider.removePantryByIndex(index),
      child: SpCard(currentPantry,
          isSelected: index == appStateProvider.selectedPantryIndex,
          isInOverviewScreen: true, onTap: () {
            final bool newIndexIsOldIndex = (index == appStateProvider.selectedPantryIndex);
            pantryProvider.switchPantry(index);
            Timer(
                Duration(
                    milliseconds: newIndexIsOldIndex
                        ? 0
                        : 300), () {
                  print(pageController);
              pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.decelerate);
            });
          }, cardText: currentPantry.title),
    );
  }
}

class AddPantryButton extends StatelessWidget {
  const AddPantryButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SpButton.filledButton(
      child: const Text('Add a pantry',
          style: kFilledButtonTextStyle),
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) => AddPantryDialog());
      },
    );
  }
}
