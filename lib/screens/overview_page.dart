import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_pantry/providers/app_state_provider.dart';
import 'package:shared_pantry/widgets/overview_card_listview.dart';
import 'package:shared_pantry/widgets/no_pantries_splash.dart';

import '../models/pantry.dart';

class OverviewPage extends StatelessWidget {
  const OverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AppStateProvider appStateProvider = context.watch<AppStateProvider>();
    final pantries = Provider.of<List<Stream<Pantry>>>(context);
    return pantries.isEmpty
        ? const NoPantriesSplash()
        : OverviewCardListView(
            context,
            appStateProvider,
          );
  }
}
