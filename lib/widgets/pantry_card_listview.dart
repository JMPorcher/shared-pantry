import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_pantry/widgets/buttons.dart';
import 'package:shared_pantry/widgets/sp_card.dart';

import '../constants.dart';
import '../dialogs/add_pantry_dialog.dart';
import '../models/pantry.dart';
import '../providers/pantry_provider.dart';

class PantryCardListView extends StatelessWidget {
  const PantryCardListView({
    super.key,
    required this.pageController,
    required this.context});

  final PageController pageController;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    final PantryProvider pantryProvider = context.watch<PantryProvider>();
    final List<Pantry> pantryList = pantryProvider.pantriesList;
    return ListView.builder(
        itemCount: pantryList.length + 1,
        itemBuilder: (_, index) {
          if (index < pantryList.length) {
            Pantry currentPantry = pantryList[index];
            return PantryCard(pantryProvider: pantryProvider, currentPantry: currentPantry, pageController: pageController, index: index,);
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
    required this.currentPantry,
    required this.pageController,
    required this.index
  });

  final PantryProvider pantryProvider;
  final Pantry currentPantry;
  final PageController pageController;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => pantryProvider.switchPantry(index),
      onLongPress: () => pantryProvider.removePantryByIndex(index),
      child: SpCard(currentPantry,
          isSelected: index == pantryProvider.selectedPantryIndex,
          isInOverviewScreen: true, onTap: () {
            final bool newIndexIsOldIndex = index == pantryProvider.selectedPantryIndex;
            pantryProvider.switchPantry(index);
            Timer(
                Duration(
                    milliseconds: newIndexIsOldIndex
                        ? 0
                        : 300), () {
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
    return SpButton(
      child: const Text('Add a pantry',
          style: kButtonTextStyle),
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) => AddPantryDialog());
      },
    );
  }
}
