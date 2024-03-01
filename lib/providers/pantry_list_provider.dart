import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/pantry.dart';
import '../services/database_services.dart';

class PantryListProvider extends StatelessWidget {
  const PantryListProvider(
      {super.key, required this.pantryIds, required this.child});

  final Widget child;
  final List<String> pantryIds;

  @override
  Widget build(BuildContext context) {
    return Provider<List<Stream<Pantry>>>(
      create: (BuildContext context) {
        return DatabaseService().streamPantryList(pantryIds);
      },
      child: child,
    );
  }
}
