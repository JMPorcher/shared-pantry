import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/database_services.dart';

class PantryIdProvider extends StatelessWidget {
  const PantryIdProvider({super.key, required this.child, required this.userId});
  final Widget child;
  final String? userId;

  @override
  Widget build(BuildContext context) {

    return StreamProvider<List<String>>(
        create: (context) => DatabaseService().streamPantrySubscriptionIds(userId),
        initialData: const [],
      child: child,
    );
  }

}