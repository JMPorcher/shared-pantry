import 'package:flutter/material.dart';
import 'package:shared_pantry/widgets/pantry_card.dart';

import '../models/pantry.dart';
import '../providers/pantry_list_provider.dart';
import 'package:provider/provider.dart';

class OverviewScreen extends StatelessWidget {
  const OverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Pantry> pantryList = context.watch<PantryProvider>().pantriesList;

    return Column(
      children: [
        SizedBox(
          height: pantryList.length * 120,
          child: ListView.builder(
              itemCount: pantryList.length,
            itemExtent: 100,
            itemBuilder: (_, index) {
                Pantry currentPantry = pantryList[index];
                return PantryCard(currentPantry);
              }),
        ),
        Text('Overview screen placeholder'),
      ]
    );
  }
}


