import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_pantry/providers/pantry_provider.dart';

import '../constants.dart';
import '../models/pantry.dart';

class SpCard extends StatelessWidget {
   const SpCard.text(
      this.cardText,
      {super.key}
      ) : pantryIndex = null, isSelected = null, height = 75;

   const SpCard.pantry(
      this.pantryIndex,
      {super.key, this.isSelected = false}
      ) : cardText = null, height = 150;

  final String? cardText;
  final int? pantryIndex;
  final bool? isSelected;
  final double height;

  @override
  Widget build(BuildContext context) {
    final Pantry pantry = context.watch<PantryProvider>().pantriesList[pantryIndex ?? 0];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: height,
        child: Card(
          color: isSelected ?? false ? kColor3 : Colors.white,
          elevation: isSelected ?? false ? 0 : 8.0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          child: Center(child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(cardText ?? pantry.title ?? ""),
          ),),
        ),
      ),
    );
  }
}