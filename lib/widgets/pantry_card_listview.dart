import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_pantry/providers/app_state_provider.dart';
import 'package:shared_pantry/services/database_services.dart';
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

    final List<String> pantryIds = context.watch<List<String>>();
    return Scaffold(
      appBar: AppBar(title: const Text('My Pantries', style: TextStyle(color: kColor1)), centerTitle: true, backgroundColor: kColor51),
      body: ListView.builder(
          itemCount: pantryIds.length + 1,
          itemBuilder: (_, index) {
            if (index < pantryIds.length) {
              return PantryProvider(
                pantryId: pantryIds[index],
                child: const PantryCard(),
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
      {super.key});

  @override
  Widget build(BuildContext context) {
    final Pantry pantry = context.watch<Pantry>();
    final AppStateProvider appStateProvider = context.watch<AppStateProvider>();
    return GestureDetector(
      onTap: () => {}, //switch screens
      onLongPress: () => DatabaseService().removePantryFromDatabase(pantry.id),
      child: OverviewScreenCard(
          isSelected: pantry.id == appStateProvider.selectedPantryId,
          title: pantry.title),
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
