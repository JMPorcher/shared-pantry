import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_pantry/widgets/overview_card_listview.dart';
import 'package:shared_pantry/widgets/no_pantries_splash.dart';

import '../models/pantry.dart';

class OverviewPage extends StatelessWidget {
  const OverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    print('Overview Page is built');
    final pantries = context.watch<List<Pantry>>();
    print('pantryList length befor building page: ${pantries.length}');
    return Consumer<List<Pantry>>(builder: (BuildContext context, List<Pantry> pantries, Widget? child) {
        return pantries.isEmpty
            ? const NoPantriesSplash()
            : OverviewCardListView();
    }
    );
  }
}
