import 'package:flutter/material.dart';

import '../constants.dart';
import '../models/pantry.dart';

class SpCard extends StatelessWidget {
   const SpCard.text(
      this.cardText,
      {Key? key}
      ) : pantry = null, isSelected = null, super(key: key);

   const SpCard.pantry(
      this.pantry,
      {Key? key, this.isSelected = false}
      ) : cardText = null, super(key: key);

  final String? cardText;
  final Pantry? pantry;
  final bool? isSelected;

  @override
  Widget build(BuildContext context) {
    //print(isSelected??'null');
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: isSelected ?? false ? kColor3 : Colors.white,
        elevation: isSelected ?? false ? 0 : 8.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        child: Center(child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(cardText ?? pantry?.title ?? ""),
        ),),
      ),
    );
  }
}