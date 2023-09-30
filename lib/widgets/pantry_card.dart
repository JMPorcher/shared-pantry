import 'package:flutter/material.dart';

import '../models/pantry.dart';

class PantryCard extends StatelessWidget {
  const PantryCard(
    this.currentPantry, {super.key}
  );

  final Pantry currentPantry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        child: Center(child: Text(currentPantry.title),),
      ),
    );
  }
}