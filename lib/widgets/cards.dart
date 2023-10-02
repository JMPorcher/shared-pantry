import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../models/pantry.dart';

class PantryCard extends StatelessWidget {
  const PantryCard.text(
      this.cardText,
      {Key? key}
      ) : pantry = null, super(key: key);

  const PantryCard.pantry(
      this.pantry,
      {Key? key}
      ) : cardText = null, super(key: key);

  final String? cardText;
  final Pantry? pantry;


  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> isSelected = ValueNotifier(false);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: isSelected.value ? kColor3 : Colors.white,
        elevation: 8.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        child: Center(child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(cardText ?? pantry?.title ?? ""),
        ),),
      ),
    );
  }
}