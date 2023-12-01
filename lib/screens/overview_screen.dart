import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_pantry/providers/app_state_provider.dart';
import 'package:shared_pantry/widgets/pantry_card_listview.dart';
import 'package:shared_pantry/widgets/no_pantries_splash.dart';

import '../models/pantry.dart';
import '../providers/pantry_provider.dart';

class OverviewScreen extends StatefulWidget {
  const OverviewScreen({super.key});

  @override
  State<OverviewScreen> createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {
  late List<Pantry> pantryList;
  late AppStateProvider appStateProvider;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    PantryProvider pantryProvider = Provider.of<PantryProvider>(context);
    appStateProvider = context.watch<AppStateProvider>();
    pantryList = pantryProvider.pantriesList;
  }

  @override
  Widget build(BuildContext context) {
    return pantryList.isEmpty
        ? const NoPantriesSplash()
        : PantryCardListView(
        context: context, appStateProvider: appStateProvider,)
    ;
  }
}



