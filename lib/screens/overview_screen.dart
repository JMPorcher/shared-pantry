import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_pantry/providers/app_state_provider.dart';
import 'package:shared_pantry/widgets/pantry_card_listview.dart';
import 'package:shared_pantry/widgets/no_pantries_splash.dart';

import '../models/pantry.dart';
import '../providers/pantry_provider.dart';

class OverviewScreen extends StatelessWidget {
  const OverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PantryProvider pantryProvider = Provider.of<PantryProvider>(context);
    final AppStateProvider appStateProvider = context.watch<AppStateProvider>();
    final List<Pantry> pantryList = pantryProvider.pantriesList;
    return pantryList.isEmpty
        ? const NoPantriesSplash()
        : PantryCardListView(
        context: context, appStateProvider: appStateProvider,)
    ;
  }
}



