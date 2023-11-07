import 'package:flutter/material.dart';

import '../constants.dart';
import '../models/pantry.dart';

class SpCard extends StatelessWidget {
  const SpCard.text(this.cardText, {super.key})
      : pantry = null,
        isSelected = null,
        height = 75;

  const SpCard.pantry(this.pantry, {super.key, this.isSelected = false})
      : cardText = null,
        height = 150;

  final String? cardText;
  final bool? isSelected;
  final double height;
  final Pantry? pantry;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Card(
        color: isSelected ?? false ? kColor3 : Colors.white,
        elevation: isSelected ?? false ? 0 : 8.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(cardText ?? pantry?.title ?? 'lol'),
          ),
        ),
      ),
    );
  }
}
