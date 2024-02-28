import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/pantry.dart';
import 'database_services.dart';

class PantryDataStream extends StatelessWidget {
  const PantryDataStream(
      {super.key, required this.child, required this.pantryIds});

  final Widget child;
  final List<String> pantryIds;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PantryDataProvider(), // Provide a data model
      child: PantryStreamWidget(pantryIds: pantryIds, child: child),
    );
  }
}

class PantryStreamWidget extends StatelessWidget {
  const PantryStreamWidget(
      {super.key, required this.pantryIds, required this.child});

  final Widget child;
  final List<String>? pantryIds;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Pantry>>(
      stream: _listOfPantryStreams(context),
      builder: (context, snapshot) {
        print('Snapshot data: ${snapshot.data}');
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (snapshot.hasError) {
          print('Error: ${snapshot.error}');
        }
        List<Pantry>? pantries = snapshot.data;
        if (pantries != null) {
          Provider.of<PantryDataProvider>(context, listen: false)
              .updatePantries(pantries);
        }
        return child; // Your widget tree
      },
    );
  }

  List<Stream<Pantry>> _listOfPantryStreams(BuildContext context) {
    List<Stream<Pantry>> pantryStreams = [];

    for (String pantryId in pantryIds!) {
      Stream<Pantry> pantryStream = DatabaseService().streamPantryDetails(pantryId);
      pantryStreams.add(pantryStream);
    }

    return pantryStreams;
  }
}

class PantryDataProvider with ChangeNotifier {
  List<Pantry> _pantries = [];

  List<Pantry> get pantries => _pantries;

  void updatePantries(List<Pantry> newPantries) {
    Future.microtask(() {
      _pantries = newPantries;
      for (var pantry in _pantries) {
        print(pantry.id);
      }
      notifyListeners();
    });
  }
}
