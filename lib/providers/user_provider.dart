import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/database_services.dart';

class UserProvider extends StatelessWidget {
  final String userId;
  final Widget child;

  const UserProvider({super.key, required this.userId, required this.child});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<String>>(
      create: (context) => DatabaseService(userId).streamSubscribedPantries(),
      initialData: const [],
      child: child,
    );
  }
}