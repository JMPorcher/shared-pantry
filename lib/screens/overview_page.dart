import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_pantry/providers/app_state_provider.dart';
import 'package:shared_pantry/widgets/pantry_card_listview.dart';
import 'package:shared_pantry/widgets/no_pantries_splash.dart';

class OverviewPage extends StatelessWidget {
  const OverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AppStateProvider appStateProvider = context.watch<AppStateProvider>();
    final List<String> pantryIds = Provider.of<List<String>>(context);
    return pantryIds.isEmpty
        ? const NoPantriesSplash()
        : OverviewCardListView(
            context,
            appStateProvider,
          );
  }
}
