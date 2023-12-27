import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_pantry/providers/app_state_provider.dart';
import 'package:shared_pantry/widgets/buttons.dart';
import 'package:shared_pantry/widgets/sp_card.dart';

import '../constants.dart';
import '../dialogs/add_pantry_dialog.dart';
import '../models/pantry.dart';
import '../providers/pantry_provider.dart';

class OverviewCardListView extends StatelessWidget {
  const OverviewCardListView(
    this.context,
    this.appStateProvider, {
    super.key,
  });

  final BuildContext context;
  final AppStateProvider appStateProvider;

  @override
  Widget build(BuildContext context) {
    final PantryProvider pantryProvider = context.watch<PantryProvider>();
    final List<Pantry> pantryList = pantryProvider.pantriesList;
    return Scaffold(
      appBar: AppBar(title: const Text('My Pantries', style: TextStyle(color: kColor1)), centerTitle: true, backgroundColor: kColor51),
      body: ListView.builder(
          itemCount: pantryList.length + 1,
          itemBuilder: (_, index) {
            if (index < pantryList.length) {
              Pantry currentPantry = pantryList[index];
              return PantryCard(
                currentPantry: currentPantry,
                index: index,
                appStateProvider: appStateProvider,
              );
            } else {
              return
                  //const AddPantryButton()
                  AddPantryCard(
                      onTap: () => AddPantryDialog(), cardText: 'Add a pantry');
            }
          }),
    );
  }
}

class PantryCard extends StatelessWidget {
  const PantryCard(
      {super.key,
      required this.appStateProvider,
      required this.currentPantry,
      required this.index});

  final AppStateProvider appStateProvider;
  final Pantry currentPantry;
  final int index;

  @override
  Widget build(BuildContext context) {
    final PantryProvider pantryProvider = context.watch<PantryProvider>();
    return GestureDetector(
      onTap: () => pantryProvider.switchPantry(index),
      onLongPress: () => pantryProvider.removePantryByIndex(index),
      child: OverviewScreenCard(
          isSelected: index == appStateProvider.selectedPantryIndex,
          index: index,
          title: currentPantry.title),
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
      child: const Text('Add a pantry', style: kFilledButtonTextStyle),
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) => AddPantryDialog());
      },
    );
  }
}
