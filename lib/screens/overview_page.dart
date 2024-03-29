import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_pantry/widgets/no_pantries_splash.dart';

import '../constants.dart';
import '../dialogs/add_pantry_dialog.dart';
import '../models/pantry.dart';
import '../providers/app_state_provider.dart';
import '../providers/pantry_provider.dart';
import '../services/database_services.dart';
import '../widgets/buttons.dart';
import '../widgets/sp_card.dart';

class OverviewPage extends StatelessWidget {
  const OverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    print('Overview Page is built');
    final List<Pantry> pantries = context.watch<PantryProvider>().pantries;
    print('pantryList length before building page: ${pantries.length}');
    return pantries.isEmpty
            ? const NoPantriesSplash()
            : const OverviewCardListView();
  }
}

class OverviewCardListView extends StatelessWidget {
  const OverviewCardListView({super.key});

  @override
  Widget build(BuildContext context) {

    final pantries = context.watch<PantryProvider>().pantries;
    print('No of pantries: ${pantries.length}');
    //TODO Use list of PantryProviders to build each card using the index on this list

    return Scaffold(
      appBar: AppBar(title: const Text('My Pantries', style: TextStyle(color: kColor1)), centerTitle: true, backgroundColor: kColor51),
      body: ListView.builder(
          itemCount: pantries.length + 1,
          itemBuilder: (_, index) {
            if (index < pantries.length) {
              return PantryCard(pantries[index]);
            } else {
              return
                AddPantryCard(
                    onTap: () => AddPantryDialog());
            }
          }),
    );
  }
}

class PantryCard extends StatelessWidget {
  const PantryCard(this.pantry,
      {super.key}
      );
  final Pantry pantry;

  @override
  Widget build(BuildContext context) {
    final AppStateProvider appStateProvider = context.watch<AppStateProvider>();
    final User? user = context.watch<User?>();
    return GestureDetector(
      onTap: () {
        print(pantry.id.toString());
        appStateProvider.newSelectedPantryId = pantry.id.toString();
        print(appStateProvider.lastShownPantryId);
      },
      onLongPress: () => DatabaseService().removePantryFromDatabase(pantry.id, user?.uid),
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