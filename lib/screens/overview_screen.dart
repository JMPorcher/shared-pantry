import 'package:flutter/material.dart';
import 'package:shared_pantry/widgets/cards.dart';

import '../models/pantry.dart';
import '../providers/pantry_list_provider.dart';
import 'package:provider/provider.dart';

class OverviewScreen extends StatelessWidget {
  const OverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Pantry> pantryList = context.watch<PantryProvider>().pantriesList;

    return SingleChildScrollView(

      child: Column(children: [
        SizedBox(
          height: pantryList.length * 240,
          child: ListView.builder(
              itemCount: pantryList.length,
              itemExtent: 200,
              itemBuilder: (_, index) {
                Pantry currentPantry = pantryList[index];
                return PantryCard.pantry(currentPantry);
              }),
        ),
        PantryCard.text(pantryList.isEmpty ? 'Add your first pantry' : 'Add a pantry')
      ]),
    );
  }
}
