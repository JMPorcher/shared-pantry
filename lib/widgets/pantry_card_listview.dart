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

    final pantryProviders = Provider.of<List<Stream<Pantry>>>(context);
    //TODO Use list of PantryProviders to build each card using the index on this list

    return Scaffold(
      appBar: AppBar(title: const Text('My Pantries', style: TextStyle(color: kColor1)), centerTitle: true, backgroundColor: kColor51),
      body: ListView.builder(
          itemCount: pantryProviders.length + 1,
          itemBuilder: (_, index) {
            if (index < pantryProviders.length) {
              return PantryCard(pantryProviders[index]);
            } else {
              return
                  AddPantryCard(
                      onTap: () => AddPantryDialog(), cardText: 'Add a pantry');
            }
          }),
    );
  }
}

class PantryCard extends StatelessWidget {
  const PantryCard(this.pantryStream,
      {super.key}
  );
  final Stream<Pantry> pantryStream;

  @override
  Widget build(BuildContext context) {
    final AppStateProvider appStateProvider = context.watch<AppStateProvider>();
    return GestureDetector(
      onTap: () => {},
        //appStateProvider.newSelectedPantryId = pantry.id.toString(),
      onLongPress: () => {},
        //DatabaseService().removePantryFromDatabase(pantry.id),
      child: OverviewScreenCard(
          isSelected: true ,
          //pantry.id == appStateProvider.selectedPantryId,
          title: 'Placeholder'
          //pantry.title),
    ));
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
